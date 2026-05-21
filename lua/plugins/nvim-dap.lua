return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
	},
	event = "User CMakeProject",
	config = function()
		local dap = require("dap")
		local utils = require("core.utils")

		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
			options = {
				detached = not utils.is_windows,
			},
			runInTerminal = true,
			externalConsole = true,
			console = "integratedTerminal",
		}
		local gdb = {
			{
				name = "Launch",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input("path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				args = {},
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
			{
				name = "Select and attach to process",
				type = "gdb",
				request = "attach",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				pid = function()
					local name = vim.fn.input("Executable name (filter): ")
					return require("dap.utils").pick_process({ filter = name })
				end,
				cwd = "${workspaceFolder}",
			},
			{
				name = "Attach to gdbserver :1234",
				type = "gdb",
				request = "attach",
				target = "localhost:1234",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
			},
		}

		dap.configurations.cpp = gdb
		dap.configurations.c = dap.configurations.cpp

		-- 调试快捷键
		vim.keymap.set({ "v", "n", "i", "t" }, "<F10>", "<cmd>DapToggleBreakpoint<CR>", { silent = true })
		vim.keymap.set({ "v", "n" }, "<F5>", function()
			local cmake = require("cmake-tools")
			local dap = require("dap")
			if dap.session() ~= nil then
				dap.continue()
			else
				local l_target = cmake.get_launch_target()
				if not l_target then
					local b_target = cmake.get_build_target()
					if b_target then
						cmake.debug({ target = b_target })
					end
				end
				cmake.debug({})
			end
		end, { desc = "debug or continue" })

		local dapui = require("dapui")
		dap.listeners.after.event_initialized.dapui_config = dapui.open

		dap.listeners.after.event_terminated.dapui_config = dapui.close

		vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointCondition", { text = "⭕", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapLogPoint", { text = "📔", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "👉", texthl = "", linehl = "", numhl = "" })
	end,
}

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
	},
	event = "User CMakeProject",
	config = function()
		local dap = require("dap")
		local utils = require("core.utils")

		--llvm-dap config refer to https://lldb.llvm.org/use/lldbdap.html
		--	adapter config
		dap.adapters["lldb-dap"] = {
			name = "lldb-dap",
			type = "executable",
			command = "lldb-dap",
			options = {
				detached = not utils.is_windows,
			},
		}

		-- launch config
		local lldb = {
			{
				name = "Launch",
				type = "lldb-dap",
				request = "launch",
				program = function()
					return vim.fn.input("path to executable: ", vim.uv.cwd() .. utils.path_separator, "file")
				end,
				cwd = function()
					return vim.uv.cwd()
				end,
				stopOnEntry = false,
				args = {},
				-- integratedTerminal or externalTerminal are not available in windows llvm-dap
				-- see https://github.com/llvm/llvm-project/pull/198573
				console = "internalConsole",
			},
		}

		dap.configurations.cpp = lldb
		dap.configurations.c = dap.configurations.cpp

		-- 调试快捷键
		vim.keymap.set({ "v", "n", "i", "t" }, "<F10>", "<cmd>DapToggleBreakpoint<CR>", { silent = true })
		vim.keymap.set({ "v", "n" }, "<F5>", function()
			local cmake = require("cmake-tools")
			if dap.session() ~= nil then
				dap.continue()
			else
				local l_target = cmake.get_launch_target()
				if not l_target then
					local b_target = cmake.get_build_target()
					if b_target then
						cmake.debug({ target = b_target })
					end
				else
					cmake.debug({ target = l_target })
				end
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

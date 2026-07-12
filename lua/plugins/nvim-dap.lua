return {
	"mfussenegger/nvim-dap",
	event = "User CMakeProject",
	dependencies = {
		"rcarriga/nvim-dap-ui",
	},
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

		local dapui = require("dapui")
		dap.listeners.after.event_initialized.dapui_config = dapui.open

		dap.listeners.after.event_terminated.dapui_config = dapui.close
		-- 调试快捷键
		vim.keymap.set({ "v", "n", "i", "t" }, "<F10>", "<cmd>DapToggleBreakpoint<CR>", { silent = true })

		vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointCondition", { text = "⭕", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapLogPoint", { text = "📔", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "👉", texthl = "", linehl = "", numhl = "" })
	end,
}

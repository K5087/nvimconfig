return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
	},
	event = "User CMakeProject",
	config = function(_, opt)
		local dap = require("dap")
		dap.adapters.codelldb = {
			type = "executable",
			command = "codelldb",
		}
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}
		dap.configurations.c = dap.configurations.cpp

		local dapui = require("dapui")

		local function startdebug()
			dapui.open()

			vim.keymap.set({ "v", "n", "i", "t" }, "<Up>", "<cmd>DapRestartFrame<CR>", { silent = true })
			vim.keymap.set({ "v", "n", "i", "t" }, "<Down>", "<cmd>DapStepOver<CR>", { silent = true })
			vim.keymap.set({ "v", "n", "i", "t" }, "<Right>", "<cmd>DapStepInto<CR>", { silent = true })
			vim.keymap.set({ "v", "n", "i", "t" }, "<Left>", "<cmd>DapStepOut<CR>", { silent = true })
		end

		local function enddebug()
			pcall(vim.keymap.del, { "v", "n", "i", "t" }, "<Up>")
			pcall(vim.keymap.del, { "v", "n", "i", "t" }, "<Down>")
			pcall(vim.keymap.del, { "v", "n", "i", "t" }, "<Left>")
			pcall(vim.keymap.del, { "v", "n", "i", "t" }, "<Right>")

			dapui.close()
		end

		dap.listeners.after.event_initialized.dapui_config = startdebug
		dap.listeners.before.event_terminated.dapui_config = enddebug
		dap.listeners.before.event_exited.dapui_config = enddebug

		vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointCondition", { text = "⭕", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapLogPoint", { text = "📔", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "👉", texthl = "", linehl = "", numhl = "" })
	end,
}

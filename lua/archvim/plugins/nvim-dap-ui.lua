return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"nvim-neotest/nvim-nio",
	},
    lazy = true,
    config = function()
        local dapui = require("dapui")
        dapui.setup()
    end
}

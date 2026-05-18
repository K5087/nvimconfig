return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	opts = {
		background_colour = "#000000",
		render = "minimal",
		minimum_width = 50,
		max_width = 100,
		timeout = 5000,
		stages = "static",
	},
	-- config = function()
	-- 	vim.notify = require("notify")
	-- end,
}

return {
	dir = "D:/Dev/cde.nvim",
	event = "VeryLazy",
	config = function()
		local cde = require("cde")
		cde.setup()
	end,
}

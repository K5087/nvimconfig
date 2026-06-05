return {
	"K5087/cfcc.nvim",
	event = "VeryLazy",
	config = function()
		local cfcc = require("cfcc")
		vim.keymap.set({ "v", "n" }, "<leader>gf", function()
			cfcc.code_action(1)
		end, { desc = "generate declarator/definition" })
	end,
}

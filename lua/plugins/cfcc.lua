return {
	"K5087/cfcc.nvim",
	-- event = "VeryLazy",
	ft = { "c", "cpp" },
	config = function()
		local cfcc = require("cfcc")
		vim.keymap.set({ "v", "n" }, "<leader>gf", function()
			cfcc.code_action(1)
		end, { desc = "generate declarator/definition" })

		vim.keymap.set({ "v", "n" }, "<leader>cf", function()
			cfcc.code_action(2, true)
		end, { desc = "copy function signature" })
	end,
}

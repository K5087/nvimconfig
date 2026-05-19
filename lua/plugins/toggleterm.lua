return {
	"akinsho/toggleterm.nvim",
	version = "*",
	event = "VeryLazy",
	opts = {
		open_mapping = { [[<C-t>]], [[<F8>]] },
	},
	config = function()
		vim.keymap.set({ "v", "n" }, "<leader>t", "<cmd>ToggleTerm direction=vertical<CR>", { silent = true })
	end,
}

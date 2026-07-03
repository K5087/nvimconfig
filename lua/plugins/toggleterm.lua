return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		open_mapping = { [[<C-t>]], [[<F8>]] },
	},
	keys = {
		{ "<leader>t", "<cmd>ToggleTerm direction=vertical<CR>", desc = "ToggleTerm" },
	},
}

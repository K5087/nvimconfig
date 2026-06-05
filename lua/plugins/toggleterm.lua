return {
	"akinsho/toggleterm.nvim",
	version = "*",
	event = "VeryLazy",
	opts = {
		open_mapping = { [[<C-t>]], [[<F8>]] },
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)
		vim.keymap.set({ "v", "n" }, "<leader>t", "<cmd>ToggleTerm direction=vertical<CR>", { silent = true })
	end,
}

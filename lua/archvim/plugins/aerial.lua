return {
	"stevearc/aerial.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
	opts = {
		layout = {
			max_width = { 40, 0.25 },
			min_width = 16,
			resize_to_content = true,
			preserve_equality = true,
		},
		keymaps = {
			["q"] = {
				callback = function()
					vim.cmd([[ :AerialClose ]])
				end,
				desc = "Close the aerial window",
				nowait = true,
			},
		},
	},
	keys = {
		{ "<F12>", "<cmd>AerialToggle!<CR>", mode = { "n" }, silent = true, noremap = true },
	},
}

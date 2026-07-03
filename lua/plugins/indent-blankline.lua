return {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufReadPost",
	main = "ibl",
	opts = {
		exclude = {
			filetypes = { "dashboard", "terminal", "help", "log", "markdown", "TelescopePrompt" },
		},
	},
}

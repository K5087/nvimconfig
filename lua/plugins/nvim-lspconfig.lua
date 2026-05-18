return {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	config = function()
		require("lsp")
	end,
}

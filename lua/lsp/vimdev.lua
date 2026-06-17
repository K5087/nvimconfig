return {
	-- Tell the server which Lua you're using (usually LuaJIT, for Neovim).
	runtime = { version = "LuaJIT" },
	diagnostics = { globals = { "vim" } },
	-- Make the server aware of Neovim runtime files.
	workspace = {
		library = {
			vim.env.VIMRUNTIME,
			-- For LSP Settings Type Annotations: https://github.com/neovim/nvim-lspconfig#lsp-settings-type-annotations
			vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
		},
		-- Or pull in all of 'runtimepath'. May be slower! https://github.com/neovim/nvim-lspconfig/issues/3189
		-- library = vim.api.nvim_get_runtime_file("", true),
	},
}

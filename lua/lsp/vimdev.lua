local M = {
	-- Set to true to add all runtimepath in workspace library
	all = false,
}

---@return table
function M:config()
	local config = {
		-- Tell the server which Lua you're using (usually LuaJIT, for Neovim).
		runtime = { version = "LuaJIT" },
		diagnostics = { globals = { "vim" } },
		-- Make the server aware of Neovim runtime files.
		workspace = {
            -- stylua: ignore start
            library = self.all and 
            -- Or pull in all of 'runtimepath'. May be slower! https://github.com/neovim/nvim-lspconfig/issues/3189
			-- library = vim.api.nvim_get_runtime_file("", true),
            vim.api.nvim_get_runtime_file("", true)
            or {
				vim.env.VIMRUNTIME,
				-- For LSP Settings Type Annotations: https://github.com/neovim/nvim-lspconfig#lsp-settings-type-annotations
				vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
			},
			-- stylua: ignore end
		},
	}
	return config
end

return M

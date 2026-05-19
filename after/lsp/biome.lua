return {
	workspace_required = false,
	root_dir = function(bufnr, on_dir)
		local filename = vim.api.nvim_buf_get_name(bufnr)

		local root = vim.fs.root(bufnr, {
			"biome.json",
			"biome.jsonc",
			".git",
		})

		on_dir(root or vim.fs.dirname(filename) or vim.fn.getcwd())
	end,
}

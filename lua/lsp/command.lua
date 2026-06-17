local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "format on save",
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		assert(client, "won't happend")
		-- enable auto completion
		-- vim.lsp.completion.enable(true, client.id, bufnr, {
		-- 	autotrigger = true,
		-- })

		-- create auto format command
		if client:supports_method("textDocument/formatting") or client.name == "biome" then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
			})
		end
	end,
})

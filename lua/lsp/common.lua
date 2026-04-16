local lsp_common = {}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
function lsp_common.on_attach(client, bufnr)
	vim.lsp.completion.enable(true, client.id, bufnr, {
		autotrigger = true,
	})
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
	end
end

return lsp_common

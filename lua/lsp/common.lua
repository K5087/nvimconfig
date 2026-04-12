local lsp_common = {}


function lsp_common.on_attach(client, bufnr)
    vim.lsp.completion.enable(true, client.id, bufnr, {
        autotrigger = true,
    })
end

return lsp_common

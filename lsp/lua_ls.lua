---@type vim.lsp.Config
return {
    ---@type lspconfig.settings.lua_ls
    settings = {
        Lua = {
            telemetry = {
                enable = false
            },
            completion = {
                callSnippet = "Replace"
            }
        }
    },
    on_attach = function (client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
    end
}

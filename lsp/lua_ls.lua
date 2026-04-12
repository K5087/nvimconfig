return {
    cmd = { 'lua-language-server' },

    filetypes = { 'lua' },

    root_markers = {
        { '.luarc.json', '.luarc.jsonc' },
        '.git',
    },

    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            telemetry = {
                enable = false,
            }

        }
    },
    on_attach = require("lsp.common").on_attach,
}

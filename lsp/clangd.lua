return {
    cmd = { "clangd", "--clang-tidy", "--header-insertion=never" },

    on_attach = require("lsp.common").on_attach,
}

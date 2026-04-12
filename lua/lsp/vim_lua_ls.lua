return {
    diagnostics = {
        globals = { "vim" },
    },

    workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
    },

    completion = {
        callSnippet = "Replace",
    }
}

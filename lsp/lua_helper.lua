return {
    cmd = { "lualsp", "-mode=1", "-logflag=0" },
    filetypes = { "lua" },
    root_dir = function(bufnr, on_dir)
        local root = vim.fs.root(bufnr, { "luahelper.json", ".git" })
        if root then
            on_dir(root)
        end
    end,

    on_attach = require("lsp.common").on_attach,

    init_options = {
        client = "neovim",
        PluginPath = vim.fn.stdpath("config"),
        RequirePathSeparator = ".",
        AllEnable = true,
    },
}

vim.api.nvim_create_user_command("VimDev", function()
    local vim_lua_ls = require("lsp.vim_lua_ls")
    vim.lsp.config("lua_ls", {
        settings = {
            Lua = vim_lua_ls
        }
    })
    if #vim.lsp.get_clients({ name = "lua_ls" }) > 0 then
        vim.cmd("lsp stop lua_ls")
    end
    vim.lsp.enable("lua_ls")
end, { desc = "enable nvim lua plugin lspserver", nargs = 0 })

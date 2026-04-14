require("lsp.option")
require("lsp.mapping")

local function check_enable(bins,config_name)
    if vim.fn.executable(bins) ==1 then
        vim.lsp.enable(config_name)
    end
end

check_enable("lua-languagte-server","lua_ls")
check_enable("clangd","clangd")

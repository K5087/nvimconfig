require("lsp.option")
require("lsp.mapping")
if vim.fn.executable("lua-language_server") then
    vim.lsp.enable("lua_ls")
end

if vim.fn.executable("clangd") then
    vim.lsp.enable("clangd")
end

require("lsp.option")
require("lsp.mapping")

local function check_enable(bin, config_name)
	if vim.fn.executable(bin) == 1 then
		vim.lsp.enable(config_name)
	end
end

check_enable("lua-language-server", "lua_ls")
check_enable("clangd", "clangd")
check_enable("stylua", "stylua")

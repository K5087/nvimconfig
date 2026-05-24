require("lsp.option")
require("lsp.mapping")
require("lsp.command")

local function check_enable(bin, config_name)
	config_name = config_name or bin
	if vim.fn.executable(bin) == 1 then
		vim.lsp.enable(config_name)
	end
end

-- lua
check_enable("lua-language-server", "lua_ls")
check_enable("stylua")

-- cpp
check_enable("clangd")

-- markdown
check_enable("rumdl")

-- json,js,css,ts
check_enable("biome")

-- query(.scm)
check_enable("ts_query_ls")

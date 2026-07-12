require("lsp.option")
require("lsp.mapping")
require("lsp.command")

local function check_enable(bin, config_name)
	config_name = config_name or bin
	if vim.fn.executable(bin) == 1 then
		vim.lsp.enable(config_name)
	else
		vim.notify("have no executable: " .. bin)
	end
end

-- lua
check_enable("emmylua_ls")
check_enable("stylua")

-- cpp
check_enable("clangd")
-- check_enable("clice")

-- cmake
check_enable("neocmakelsp", "neocmake")

-- markdown
check_enable("rumdl")

-- json,js, css, ts
check_enable("biome")

-- query(.scm)
check_enable("ts_query_ls")

-- python
check_enable("basedpyright")

-- python code action
check_enable("ruff")

-- nushell
check_enable("nu", "nushell")

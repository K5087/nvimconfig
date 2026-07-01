---@type vim.lsp.Config
return {
	on_init = function(client)
		-- If the workspace has its own emmylua_ls/lua_ls config file, defer to it.
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.emmyrc.json") or vim.uv.fs_stat(path .. "/.luarc.json"))
			then
				client.config.settings = {}
			end
		end
	end,
	settings = {
		emmylua = require("lsp.vimdev"):config(),
	},
}

return {
	cmd = { "lua-language-server" },

	filetypes = { "lua" },

	root_markers = {
		{ ".luarc.json", ".luarc.jsonc" },
		".git",
	},

	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			telemetry = {
				enable = false,
			},
			completion = {
				callSnippet = "Replace",
			},
		},
	},
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
	end,
}

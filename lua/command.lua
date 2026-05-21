vim.api.nvim_create_user_command("VimDev", function()
	local vim_lua_ls = require("lsp.vim_lua_ls")
	vim.lsp.config("lua_ls", {
		settings = {
			Lua = vim_lua_ls,
		},
	})
	if #vim.lsp.get_clients({ name = "lua_ls" }) > 0 then
		vim.cmd("lsp stop lua_ls")
	end
	vim.lsp.enable("lua_ls")
	vim.notify("enable vim lua dev environment")
end, { desc = "enable nvim lua plugin lspserver", nargs = 0 })

vim.api.nvim_create_user_command("LuaWork", function()
	vim.lsp.enable("lua_ls", false)
	if #vim.lsp.get_clients({ name = "lua_ls" }) > 0 then
		vim.cmd("lsp stop lua_ls")
	end

	vim.lsp.enable("lua_helper")
	vim.notify("enable luahelper")
end, { desc = "for moke's work", nargs = 0 })

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"help",
		"lspinfo",
		"checkhealth",
		"qf",
		"grug-far",
	},
	callback = function(event)
		vim.keymap.set("n", "q", function()
			vim.cmd("close")
		end, { buffer = event.buf, silent = true })
	end,
})

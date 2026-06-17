vim.api.nvim_create_user_command("VimDev", function()
	local vim_emmylua_ls = require("lsp.vim_emmylua_ls")
	vim.lsp.config("emmylua_ls", vim_emmylua_ls)
	if #vim.lsp.get_clients({ name = "emmylua_ls" }) > 0 then
		vim.cmd("lsp stop emmylua_ls")
	end
	vim.lsp.enable("emmylua_ls")
	vim.notify("enable vim lua dev environment")
end, { desc = "enable nvim lua plugin lspserver", nargs = 0 })

vim.api.nvim_create_user_command("LuaWork", function()
	vim.lsp.enable("emmylua_ls", false)
	if #vim.lsp.get_clients({ name = "emmylua_ls" }) > 0 then
		vim.cmd("lsp stop lua_ls")
	end

	vim.lsp.enable("lua_helper")
	vim.notify("enable luahelper")
end, { desc = "for moke's work", nargs = 0 })

-- 使用快捷键快速退出这些窗口
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

-- 打开buffer时回到上一次的光标位置
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(event)
		local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
		local lcount = vim.api.nvim_buf_line_count(event.buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

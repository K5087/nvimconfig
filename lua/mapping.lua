-- 退出快捷键
vim.api.nvim_create_user_command("Quit", function()
	vim.cmd("wall")
	local cmd = "quit"
	if vim.bo.buftype == "quickfix" then
		if vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 then
			cmd = "lclose"
		else
			cmd = "cclose"
		end
	elseif vim.bo.buftype == "prompt" then
		cmd = "quit!"
	else
		cmd = "quit"
	end
	vim.cmd(cmd)
end, { desc = "Quit current window" })
vim.keymap.set("n", "<leader>q", "<cmd>Quit<CR>", { silent = true })
vim.keymap.set("v", "<leader>q", "<Esc>", { silent = true })
vim.keymap.set("n", "<leader>Q", "q", { silent = true, noremap = true })

-- 撤销快捷键
vim.keymap.set({ "n", "i", "v" }, "<C-z>", "<Esc>:u<CR>", { silent = true })

vim.keymap.set({ "v", "n", "i" }, "<F4>", "<cmd>wa<CR>", { desc = "save buffer" })
vim.keymap.set({ "v", "n", "i" }, "<F6>", "<cmd>cclose | Trouble qflist toggle<CR>")

-- 头文件/源文件跳转
vim.keymap.set({ "v", "n" }, "<leader><Tab>", "<cmd>LspClangdSwitchSourceHeader<CR>", { silent = true })
vim.keymap.set({ "v", "n" }, "<leader>v<Tab>", "<cmd>vsplit | LspClangdSwitchSourceHeader<CR>", { silent = true })
vim.keymap.set({ "v", "n" }, "<leader>h<Tab>", "<cmd>split | LspClangdSwitchSourceHeader<CR>", { silent = true })

-- 移动选中行
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<CR>==", { silent = true, desc = "Move line down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<CR>==", { silent = true, desc = "Move line up" })

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

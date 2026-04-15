-- 退出快捷键
vim.api.nvim_create_user_command("Quit", function()
	vim.cmd(
		[[ wall | if &buftype == 'quickfix' | cclose | elseif &buftype == 'prompt' | quit! | else | quit | endif ]],
		{ desc = "quit command" }
	)
end, { desc = "Quit current window" })
vim.keymap.set("n", "<leader>q", "<cmd>Quit<CR>", { silent = true })
vim.keymap.set("v", "<leader>q", "<Esc>", { silent = true })
vim.keymap.set("n", "<leader>Q", "<cmd>Quit<CR>", { silent = true, noremap = true })

-- 撤销快捷键
vim.keymap.set({ "n", "i", "v" }, "<C-z>", "<Esc>:u<CR>", { desc = "revocation input", silent = true })

-- 跳转行开头和结尾
vim.keymap.set(
	{ "v", "n" },
	"gh",
	"(v:count == 0 || v:count == 1 ? '^^' : '^^' . (v:count - 1) . 'l')",
	{ silent = true, expr = true }
)

vim.keymap.set(
	{ "v", "n" },
	"gl",
	"(v:count == 0 || v:count == 1 ? '^$' : '^$' . (v:count - 1) . 'h')",
	{ silent = true, expr = true }
)
vim.keymap.set({ "v", "n", "i" }, "<F4>", "<cmd>wa<CR>", { desc = "save buffer" })

-- 移动选中行
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<CR>==", { silent = true, desc = "Move line down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<CR>==", { silent = true, desc = "Move line up" })

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

-- 打开文件浏览器
vim.keymap.set({ "n", "v", "i", "t" }, "<C-Tab>", "<cmd>Ex<CR>", { desc = "open file explore" })

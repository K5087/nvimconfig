local set = vim.keymap.set

-- 退出
set("n", "<leader>q", "<cmd>q<CR>", { silent = true })

-- 撤销快捷键
set({ "n", "i", "v" }, "<C-z>", "<Esc>:u<CR>", { silent = true })

set({ "v", "n", "i" }, "<F4>", "<cmd>wa<CR>", { desc = "save buffer" })
set({ "v", "n", "i" }, "<F6>", "<cmd>cclose | Trouble qflist toggle<CR>")

-- 头文件/源文件跳转
set({ "v", "n" }, "<leader><Tab>", "<cmd>LspClangdSwitchSourceHeader<CR>", { silent = true })
set({ "v", "n" }, "<leader>v<Tab>", "<cmd>vsplit | LspClangdSwitchSourceHeader<CR>", { silent = true })
set({ "v", "n" }, "<leader>h<Tab>", "<cmd>split | LspClangdSwitchSourceHeader<CR>", { silent = true })

-- 移动选中行
set("n", "<A-j>", "<cmd>m .+1<CR>==", { silent = true, desc = "Move line down" })
set("n", "<A-k>", "<cmd>m .-2<CR>==", { silent = true, desc = "Move line up" })

set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

-- 快速跳转行开头和结尾
set("n", "gl", "$", { desc = "Go to end of line" })
set("n", "gh", "^", { desc = "Go to start of line" })

-- 打开文件浏览器
vim.keymap.set({ "n", "v", "t" }, "<leader>e", "<cmd>Ex<CR>", { desc = "open file explore" })

-- 打开关闭terminal
vim.keymap.set({ "n", "v" }, "<leader>t", "<cmd>terminal<CR>", { desc = "open terminal" })
vim.keymap.set("t", "<leader>t", [[<C-\><C-n>:close<CR>]], {
	desc = "close terminal",
})

local set = vim.keymap.set
set({ "n", "v" }, "<leader>q", "<cmd>q<CR>", { desc = "quit command" })

-- 撤销快捷键
set({ "n", "i", "v" }, "<C-z>", "<Esc>:u<CR>", { silent = true, desc = "undo command" })

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

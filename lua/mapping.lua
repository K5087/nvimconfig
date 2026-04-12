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

-- 格式化代码
vim.keymap.set({ "v", "n" }, "g=", function()
    vim.lsp.buf.format()
end)

-- 移动选中行
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<CR>==", { silent = true, desc = "Move line down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<CR>==", { silent = true, desc = "Move line up" })

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

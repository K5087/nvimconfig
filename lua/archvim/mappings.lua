-- 退出快捷键
vim.api.nvim_create_user_command("Quit", function()
	vim.cmd([[ wall | if &buftype == 'quickfix' | cclose | elseif &buftype == 'prompt' | quit! | else | quit | endif ]])
end, { desc = "Quit current window" })
vim.keymap.set("n", "q", "<cmd>Quit<CR>", { silent = true })
vim.keymap.set("v", "q", "<Esc>", { silent = true })
vim.keymap.set("n", "Q", "q", { silent = true, noremap = true })

vim.keymap.set("i", "jk", "<Esc>", { silent = true })
vim.keymap.set("i", "kj", "<Esc>", { silent = true })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { silent = true })
vim.keymap.set("t", "kj", "<C-\\><C-n>", { silent = true })

-- 复制粘贴快捷键
vim.keymap.set({ "n", "v" }, "<C-Insert>", '"+y', { silent = true })
vim.keymap.set("i", "<C-Insert>", '<Esc>"+yya', { silent = true })
vim.keymap.set({ "n", "v" }, "<S-Insert>", '"+p', { silent = true })
vim.keymap.set("i", "<S-Insert>", "<C-r>+", { silent = true })

-- 撤销快捷键
vim.keymap.set(
	{ "n", "i","v" },
	"<C-z>",
    "<Esc>:u<CR>",
	{ silent = true,}
)

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
vim.keymap.set({ "v", "n", "i" }, "<F4>", "<cmd>wa<CR>")
vim.keymap.set({ "v", "n", "i" }, "<F6>", "<cmd>cclose | Trouble qflist toggle<CR>")

-- 格式化代码
vim.keymap.set({ "v" }, "g=", [[<Cmd>Neoformat<CR>]])

vim.keymap.set({ "v", "n", "i" }, "<F16>", function()
	vim.lsp.buf.format()
end)

-- 插件快捷键
-- vim.keymap.set({"v", "n", "i", "t"}, "<F7>", "<cmd>NvimTreeFindFileToggle<CR>", { silent = true })

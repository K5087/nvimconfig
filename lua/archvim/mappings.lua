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

-- esc时取消高亮
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { noremap = true, silent = true })

-- 复制粘贴快捷键(该快捷键是否保留?)
vim.keymap.set({ "n", "v" }, "<C-Insert>", '"+y', { silent = true })
vim.keymap.set("i", "<C-Insert>", '<Esc>"+yya', { silent = true })
vim.keymap.set({ "n", "v" }, "<S-Insert>", '"+p', { silent = true })
vim.keymap.set("i", "<S-Insert>", "<C-r>+", { silent = true })

-- 撤销快捷键
vim.keymap.set({ "n", "i", "v" }, "<C-z>", "<Esc>:u<CR>", { silent = true })

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
vim.keymap.set({ "v", "n", "i" }, "<F6>", "<cmd>cclose | Trouble qflist toggle<CR>")

-- 格式化代码
vim.keymap.set({ "v", "n" }, "g=", function()
	vim.lsp.buf.format()
end)

-- 查找符号定义
vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Goto definition" })
-- 查找符号声明
vim.keymap.set("n", "gD", function()
	vim.lsp.buf.declaration()
end, { desc = "Goto declaration" })
-- 查找类型定义
vim.keymap.set({ "v", "n" }, "gy", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Goto type definition" })
-- 查找所有引用
vim.keymap.set({ "v", "n" }, "gr", "<cmd>Telescope lsp_references<CR>", { desc = "Find references" })
-- 删除预定义的一些干扰
pcall(vim.keymap.del, { "n" }, "gri")
pcall(vim.keymap.del, { "n" }, "grr")
pcall(vim.keymap.del, { "v", "n" }, "gra")
pcall(vim.keymap.del, { "n" }, "grn")
pcall(vim.keymap.del, { "v" }, "grc")
pcall(vim.keymap.del, { "n" }, "grt")
-- 查找函数实现
vim.keymap.set({ "v", "n" }, "gY", "<cmd>Telescope lsp_implementations<CR>", { desc = "Find implementations" })
-- 查看全部
vim.keymap.set({ "v", "n" }, "gz", "<cmd>Trouble lsp toggle<CR>")
-- 查看类型继承图
vim.keymap.set({ "v", "n" }, "gst", function()
	vim.lsp.buf.typehierarchy("subtypes")
end, { desc = "List derived class hierarchy" })
vim.keymap.set({ "v", "n" }, "gsT", function()
	vim.lsp.buf.typehierarchy("supertypes")
end, { desc = "List base class hierarchy" })

-- 查找文件
vim.keymap.set("n", "gfd", "<cmd>Telescope fd<CR>", { desc = "serach file by name" })
vim.keymap.set("n", "gip", "<cmd>Telescope live_grep<CR>", { desc = "search file by content" })

-- 头文件/源文件跳转
vim.keymap.set({ "v", "n" }, "<leader><Tab>", "<cmd>LspClangdSwitchSourceHeader<CR>", { silent = true })
vim.keymap.set({ "v", "n" }, "<leader>v<Tab>", "<cmd>vsplit | LspClangdSwitchSourceHeader<CR>", { silent = true })
vim.keymap.set({ "v", "n" }, "<leader>h<Tab>", "<cmd>split | LspClangdSwitchSourceHeader<CR>", { silent = true })

-- 移动选中行
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<CR>==", { silent = true, desc = "Move line down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<CR>==", { silent = true, desc = "Move line up" })

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

-- 调试快捷键，其他快捷键请看dap插件设置
vim.keymap.set({ "v", "n", "i", "t" }, "<F10>", "<cmd>DapToggleBreakpoint<CR>", { silent = true })
vim.keymap.set({ "v", "n" }, "<F5>", function()
	local cmake = require("cmake-tools")
	local dap = require("dap")
	if dap.session() ~= nil then
		dap.continue()
	else
		local l_target = cmake.get_launch_target()
		if not l_target then
			local b_target = cmake.get_build_target()
			if b_target then
				cmake.debug({ target = b_target })
			end
		end
		cmake.debug({})
	end
end, { desc = "debug or continue" })

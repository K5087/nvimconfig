-- 手动触发lsp补全
vim.keymap.set("i", "<C-Space>", vim.lsp.completion.get, { desc = "trigger completion" })

-- 使用tab选择弹出窗口下一个选项
vim.keymap.set("i", "<Tab>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-n>"
	else
		return "<Tab>"
	end
end, { desc = "select popup menu next", expr = true })

-- 接受当前补全
vim.keymap.set({ "i" }, "<A-y>", "<C-y>", { desc = "accept current completion" })

-- 跳转至下一个代码片段
vim.keymap.set({ "i", "n" }, "<A-n>", function()
	vim.snippet.jump(1)
end, { desc = "jump to next snippet" })

-- 跳转至上一个代码片段
vim.keymap.set({ "i", "n" }, "<A-p>", function()
	vim.snippet.jump(-1)
end, { desc = "jump to prev snippet" })

-- lsp相关能力
-- gra
vim.keymap.set({ "n", "i", "v" }, "<A-a>", vim.lsp.buf.code_action, { desc = "code action" })
vim.keymap.set({ "n", "i", "v" }, "<A-D>", vim.lsp.buf.declaration, { desc = "declaration" })
vim.keymap.set({ "n", "i", "v" }, "<A-d>", vim.lsp.buf.definition, { desc = "definition" })
vim.keymap.set({ "n", "i", "v" }, "<A-h>l", vim.lsp.buf.document_highlight, { desc = "document_highlight" })
-- gO
vim.keymap.set({ "n", "i", "v" }, "<A-s>d", vim.lsp.buf.document_symbol, { desc = "document_symbol" })
vim.keymap.set({ "n", "i", "v" }, "<A-=>", vim.lsp.buf.format, { desc = "fortmat" })
-- gri
vim.keymap.set({ "n", "i", "v" }, "<A-i>", vim.lsp.buf.implementation, { desc = "implementation" })

vim.keymap.set({ "n", "i", "v" }, "<A-c>", vim.lsp.buf.incoming_calls, { desc = "incoming_calls" })
vim.keymap.set({ "n", "i", "v" }, "<A-w>f", vim.lsp.buf.list_workspace_folders, { desc = "list_workspace_folders" })
vim.keymap.set({ "n", "i", "v" }, "<A-o>c", vim.lsp.buf.outgoing_calls, { desc = "outgoing_calls" })
-- grr
vim.keymap.set({ "n", "i", "v" }, "<A-r>", vim.lsp.buf.references, { desc = "references" })
-- grd
vim.keymap.set({ "n", "i", "v" }, "<A-m>", vim.lsp.buf.rename, { desc = "rename" })
vim.keymap.set({ "n", "i", "v" }, "<A-v>", vim.lsp.buf.selection_range, { desc = "selection_range" })
-- <C-s>(insert)
vim.keymap.set({ "n", "i", "v" }, "<A-s>h", vim.lsp.buf.signature_help, { desc = "signature_help" })
-- grt
vim.keymap.set({ "n", "i", "v" }, "<A-t>", vim.lsp.buf.type_definition, { desc = "type_definition" })
vim.keymap.set({ "n", "i", "v" }, "<A-u>", vim.lsp.buf.typehierarchy, { desc = "typeHierarchy" })
vim.keymap.set({ "n", "i", "v" }, "<A-s>w", vim.lsp.buf.workspace_symbol, { desc = "workspace_symbol" })

-- K
-- vim.keymap.set({ "n", "i", "v" }, "<A-k>", vim.lsp.buf.hover, { desc = "hover" })

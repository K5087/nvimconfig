-- 手动触发lsp补全
vim.keymap.set("i", "<C-Space>", function()
    vim.lsp.completion.get()
end, { desc = "trigger completion" })

-- 使用tab选择弹出窗口下一个选项
vim.keymap.set("i", "<Tab>", function()
    if vim.fn.pumvisible() == 1 then
        return "<C-n>"
    else
        return "<Tab>"
    end
end, { desc = "select popup menu next", expr = true })

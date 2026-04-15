local function test()
    local parser, err = vim.treesitter.get_parser(0)
    if not parser then
        vim.print(err)
        return
    end
    local tree = parser:parse()[1]
    local root = tree:root()
    return root:child_count()
end
vim.print("helo")

vim.pack.add {
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" }
}
-- nvim自带 {"c","lua","markdown","markdown_inline","vim","vimdoc","query"}
local extern_language = { "cpp" }

-- 为哪些语言启用treesitter插件功能
local enable_language = { "c", "lua", "cpp", "markdown", "vimscript", "vimdoc", "treesitter" }

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    once = true,
    callback = function()
        local treesitter = require("nvim-treesitter")
        treesitter.setup {}
        treesitter.install(extern_language)
    end
})

-- 为这些语言启用语法高亮,折叠和缩进功能
-- 若想要细粒度的控制,请在ftplugin/(filetype).lua文件中编辑
vim.api.nvim_create_autocmd("FileType", {
    pattern = enable_language,
    -- pattern = vim.treesitter.language._complete(),
    callback = function()
        vim.treesitter.start()
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[0][0].foldmethod = "expr"
        vim.wo[0][0].foldlevel = 99
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

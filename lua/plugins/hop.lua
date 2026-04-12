
vim.pack.add {
    { src = "https://github.com/smoka7/hop.nvim" },
}

vim.api.nvim_create_autocmd("BufEnter", {
    once = true,
    callback = function()
        local hop = require("hop")
        hop.setup { keys =  "etovxqpdygfblzhckisuran"  }
        -- vim.keymap.set('', '<Space>', function()
        --     hop.hint_char1({ current_line_only = false })
        -- end, { remap = true })
        local directions = require('hop.hint').HintDirection
        vim.keymap.set('', 'f', function()
            hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
        end, { remap = true })
        vim.keymap.set('', 'F', function()
            hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
        end, { remap = true })
        vim.keymap.set('', 't', function()
            hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
        end, { remap = true })
        vim.keymap.set('', 'T', function()
            hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
        end, { remap = true })
    end
})

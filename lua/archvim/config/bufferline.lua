return {
    "akinsho/bufferline.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    event = "BufWinEnter",
    config = function()
        require("bufferline").setup({
            options = {
                buffer_close_icon = 'x',
                modified_icon = '*',
                left_trunc_marker = '<',
                right_trunc_marker = '>',
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(count)
                    return "("..count..")"
                end,
                sort_by = 'insert_after_current',
                custom_filter = function(buf_number)
                    if vim.bo[buf_number].filetype == "qf" then return false end
                    if vim.bo[buf_number].buftype == "terminal" then return false end
                    if vim.bo[buf_number].buftype == "nofile" then return false end
                    if vim.bo[buf_number].filetype == "Trouble" then return false end
                    return true
                end,
            },
        })

        local function close_empty_unnamed_buffers()
            for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(bufnr)
                        and vim.api.nvim_buf_get_name(bufnr) == ''
                        and vim.bo[bufnr].buftype == '' then
                    if vim.api.nvim_buf_line_count(bufnr) == 1 then
                        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)
                        if #lines == 0 or lines[1] == nil or #lines[1] == 0 then
                            vim.api.nvim_buf_delete(bufnr, { force = true })
                        end
                    end
                end
            end
        end

        vim.api.nvim_create_autocmd("BufReadPost", {
            callback = close_empty_unnamed_buffers,
        })
    end,

    keys = {
        { "g<Tab>", "<cmd>BufferLineTogglePin<CR>", mode = { "n", "v" } },
        { "gb",         "<cmd>BufferLineCyclePrev<CR>", mode = { "n", "v" } },
        { "gt",         "<cmd>BufferLineCycleNext<CR>", mode = { "n", "v" } },
        { "g<Space>", "<cmd>BufferLinePick<CR>", mode = { "n", "v" } },
        { "g<BS>", "<cmd>bdelete<CR>", mode = { "n", "v" } },
        { "gB", "<cmd>BufferLineMovePrev<CR>", mode = { "n", "v" } },
        { "gT", "<cmd>BufferLineMoveNext<CR>", mode = { "n", "v" } },
        { "g<S-Tab>", "<cmd>BufferLineCloseOthers<CR>", mode = { "n", "v" } },
        { "g<C-b>", "<cmd>BufferLineCloseLeft<CR>", mode = { "n", "v" } },
        { "g<C-t>", "<cmd>BufferLineCloseRight<CR>", mode = { "n", "v" } },

        { "<F1>", "<cmd>BufferLineTogglePin<CR>", mode = { "n", "v", "i" } },
        { "<F2>", "<cmd>BufferLineCyclePrev<CR>", mode = { "n", "v", "i" } },
        { "<F3>", "<cmd>BufferLineCycleNext<CR>", mode = { "n", "v", "i" } },
        { "<F13>", "<cmd>bdelete<CR>", mode = { "n", "v", "i" } },
        { "<F14>", "<cmd>BufferLineMovePrev<CR>", mode = { "n", "v", "i" } },
        { "<F15>", "<cmd>BufferLineMoveNext<CR>", mode = { "n", "v", "i" } },
        { "<C-F13>", "<cmd>BufferLineCloseOthers<CR>", mode = { "n", "v", "i" } },
        { "<C-F14>", "<cmd>BufferLineCloseLeft<CR>", mode = { "n", "v", "i" } },
        { "<C-F15>", "<cmd>BufferLineCloseRight<CR>", mode = { "n", "v", "i" } },
    },

    lazy = false,
}


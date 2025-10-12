return {
    "smoka7/hop.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
        {"<Space>",function() require("hop").hint_char1({ current_line_only = false }) end,remap = true}
    }
}


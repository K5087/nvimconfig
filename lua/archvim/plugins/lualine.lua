return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
	opts = {
		options = {
			theme = "auto",
			globalstatus = true,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
		},
		disabled_filetypes = {
			statusline = { "dashboard" },
			winbar = { 'dashboard' }
		},
		extensions = { "nvim-tree" },
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diagnostics" },
			lualine_c = {},
			lualine_x = {
				"filesize",
				"encoding",
			},
			lualine_y = {},
			lualine_z = { "lsp_status" },
		},
	},
    config = function (_,opts)
       -- require("lualine").setup(opts)
    end
}

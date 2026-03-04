return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
	opts = {
		options = {
			theme = "auto",
			globalstatus = false,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = { "dashboard" },
				winbar = {
					"dashboard",
					"dap-repl",
					"dapui_scopes",
					"dapui_breakpoints",
					"dapui_stacks",
					"dapui_watches",
					"dapui_console",
				},
			},
		},
		extensions = { "nvim-tree" },
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diagnostics" },
			lualine_c = { "filename" },
			lualine_x = {
				"filesize",
				"encoding",
			},
			lualine_y = {},
			lualine_z = { "lsp_status" },
		},
		winbar = {
			lualine_x = {},
			lualine_y = { "fileformat" },
			lualine_z = {},
		},
		inactive_winbar = {
			lualine_x = {},
			lualine_y = { "fileformat" },
			lualine_z = {},
		},
	},
	config = function(_, opt)
		local auto = require("lualine.themes.auto")
		local lualine_modes = { "insert", "normal", "visual", "command", "replace", "inactive", "terminal" }
		for _, field in ipairs(lualine_modes) do
			if auto[field] and auto[field].c then
				auto[field].c.bg = "NONE"
			end
		end
		opt.options.theme = auto
		require("lualine").setup(opt)
	end,
}

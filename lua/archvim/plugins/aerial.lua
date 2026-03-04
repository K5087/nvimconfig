return {
	"stevearc/aerial.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		layout = {
			max_width = { 40, 0.25 },
			min_width = 16,
			resize_to_content = true,
			preserve_equality = true,
		},
		keymaps = {
			["q"] = {
				callback = function()
					vim.cmd([[ :AerialClose ]])
				end,
				desc = "Close the aerial window",
				nowait = true,
			},
		},
	},
	config = function(_, opts)
		require("aerial").setup(opts)

		local lualine = require("lualine")
		local lualine_opt = lualine.get_config()

		local aerial = {
			"aerial",
			-- cond = function()
			-- 	return vim.bo.buftype == ""
			-- end,
			on_click = function(n, mouse)
				if n == 1 then
					if mouse == "l" then
						vim.cmd([[AerialToggle]])
					end
				end
			end,
		}
		lualine_opt.winbar.lualine_x = { aerial }
		lualine_opt.inactive_winbar.lualine_x = { aerial }

		lualine.setup(lualine_opt)
	end,
	keys = {
		{ "<F12>", "<cmd>AerialToggle!<CR>", mode = { "n" }, silent = true, noremap = true },
	},
}

return {
	"glepnir/zephyr-nvim",
	event = "UIEnter",
	lazy = false,
	priority = 1000,
	config = function()
		-- vim.cmd("colorscheme zephyr")
		-- vim.cmd([[
		--   hi Normal guibg=NONE ctermbg=NONE
		--   hi NormalNC guibg=NONE ctermbg=NONE
		--   hi VertSplit guibg=NONE
		--   hi StatusLine guibg=NONE
		-- ]])
		vim.schedule(function()
			vim.cmd("colorscheme zephyr")
			vim.cmd([[
		              hi Normal guibg=NONE ctermbg=NONE
		              hi NormalNC guibg=NONE ctermbg=NONE
		          ]])
		end)
	end,
}

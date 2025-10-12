return {
	"glepnir/zephyr-nvim",
	config = function()
		vim.cmd("colorscheme zephyr")
		vim.cmd([[
  hi Normal guibg=NONE ctermbg=NONE
  hi NormalNC guibg=NONE ctermbg=NONE
  hi VertSplit guibg=NONE
  hi StatusLine guibg=NONE
]])
	end,
}

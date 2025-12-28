return {
	"glepnir/zephyr-nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd("colorscheme zephyr")
		vim.cmd([[
		    hi Normal guibg=NONE ctermbg=NONE
		    hi NormalNC guibg=NONE ctermbg=NONE
		    hi VertSplit guibg=NONE
		    hi StatusLine guibg=NONE
            hi WinBar guibg=NONE ctermbg=NONE
            hi WinBarNC guibg=NONE ctermbg=NONE

		]])
		-- 这里的异步会导致lualine在第一次启动dashboard时错误
		-- vim.schedule(function()
		-- 	vim.cmd("colorscheme zephyr")
		-- 	vim.cmd([[
		--               hi Normal guibg=NONE ctermbg=NONE
		--               hi NormalNC guibg=NONE ctermbg=NONE
		--           ]])
		-- end)
	end,
}

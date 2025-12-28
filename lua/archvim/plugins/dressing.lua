-- 该插件用于解决vim.ui.slect->vim.fn.inputlist()导致的与noice配合问题,等待修复后可以移除
return {
	"stevearc/dressing.nvim",
    event = "VeryLazy"
	opts = {},
}

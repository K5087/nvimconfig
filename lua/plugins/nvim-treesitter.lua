-- nvim自带 {"c","lua","markdown","markdown_inline","vim","vimdoc","query"}
local default_language = { "c", "lua", "markdown", "markdown_inline", "vim", "vimdoc", "query" }
local extern_language = { "cpp", "json" }

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	branch = "main",
	opts = {
		ensure_installed = extern_language,
		auto_install = true,
		highlight = {
			enable = true,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "+",
				node_incremental = "+",
				node_decremental = "-",
				-- scope_incremental = '+',
			},
		},
		indent = { enable = true },
	},
	config = function()
		local TS = require("nvim-treesitter")

		local installed = TS.get_installed()
		local pattern = {}
		for _, parser in ipairs(extern_language) do
			local has_parser = installed[parser]
			if not has_parser then
				TS.install(parser)
			else
				vim.list_extend(pattern, vim.treesitter.language.get_filetypes(parser))
			end
		end

		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.opt.foldenable = true
		vim.opt.foldlevel = 99
	end,
}

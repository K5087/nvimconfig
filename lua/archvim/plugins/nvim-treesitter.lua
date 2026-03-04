return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	-- event = "VeryLazy",
	ft = { "BufReadPost", "BufNewFile" },
	branch = "main",
	opts = {
		ensure_installed = { "bash", "c", "cpp", "lua", "markdown", "json" },
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
	config = function(_, opts)
		local TS = require("nvim-treesitter")
		TS.setup(opts)

		local installed = TS.get_installed()
		local pattern = {}
		for _, parser in ipairs(opts.ensure_installed) do
			local has_parser = installed[parser]
			if not has_parser then
				TS.install(parser)
			else
				vim.list_extend(pattern, vim.treesitter.language.get_filetypes(parser))
			end
		end
		-- vim.api.nvim_create_autocmd("FileType", {
		-- 	pattern = pattern,
		-- 	callback = function()
		-- 		vim.treesitter.start()
		-- 	end,
		-- })
		-- vim.api.nvim_exec_autocmds("FileType", {})

		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.opt.foldenable = true
		vim.opt.foldlevel = 99
	end,
}

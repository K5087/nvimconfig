local ensure_installed = {
	"bash",
	"c",
	"cpp",
	"lua",
	"markdown",
	"json",
	"vim",
	"vimdoc",
}
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	-- event = "VeryLazy",
	ft = ensure_installed,
	branch = "main",
	opts = {
		ensure_installed = ensure_installed,
		auto_install = true,
		highlight = {
			enable = true,
		},
	},

	config = function(_, opts)
		local nvim_treesitter = require("nvim-treesitter")
		nvim_treesitter.setup(opts)

		local parsers = require("nvim-treesitter.parsers")
		local pattern = {}
		for _, parser in ipairs(opts.ensure_installed) do
			local has_parser = parsers[parser]
			if not has_parser then
				nvim_treesitter.install(parser)
			else
				vim.list_extend(pattern, vim.treesitter.language.get_filetypes(parser))
			end
		end
		vim.api.nvim_create_autocmd("FileType", {
			pattern = pattern,
			callback = function()
				vim.treesitter.start()
			end,
		})
		vim.api.nvim_exec_autocmds("FileType", {})
	end,
}

return {
	"nvimdev/lspsaga.nvim",
	cmd = "Lspsaga",
	opts = {
		finder = {
			keys = {
				toggle_or_open = "<CR>",
			},
		},
	},
	keys = {
		{ "gA", "<cmd>Lspsaga code_action<CR>", mode = { "n" }, silent = true, noremap = true },
		{ "gA", "<cmd>Lspsaga range_code_action<CR>", mode = { "v" }, silent = true, noremap = true },

		{ "gR", "<cmd>Lspsaga rename<CR>", mode = { "n" }, silent = true, noremap = true },

		{ "gK", "<cmd>Lspsaga preview_definition<CR>", mode = { "n" }, silent = true, noremap = true },

		{ "K", "<cmd>Lspsaga hover_doc<CR>", mode = { "n" }, silent = true, noremap = true },
		-- { "<C-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", mode = { "n" }, silent = true, noremap = true },
		-- { "<C-b>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", mode = { "n" }, silent = true, noremap = true },
		{ "gsk", "<cmd>Lspsaga show_line_diagnostics<CR>", mode = { "n" }, silent = true, noremap = true },

        { "[a", "<cmd>Lspsaga diagnostic_jump_prev<CR>", mode = { "n" }, silent = true, noremap = true },
        { "]a", "<cmd>Lspsaga diagnostic_jump_next<CR>", mode = { "n" }, silent = true, noremap = true },
	},
}

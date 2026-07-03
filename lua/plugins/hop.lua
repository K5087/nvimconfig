return {
	"smoka7/hop.nvim",
	opts = {},
	keys = {
		{
			"<leader><Space>",
			function()
				require("hop").hint_char1({ current_line_only = false })
			end,
			remap = true,
		},
	},
}

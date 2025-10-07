return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	opts = {
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
		hijack_cursor = false,
		filters = {
			custom = { "^.git$" },
		},
		renderer = {
			icons = {
				web_devicons = {
					file = {
						enable = true,
						color = true,
					},
					folder = {
						enable = false,
						color = true,
					},
				},
				show = {
					file = true,
					folder = true,
					folder_arrow = true,
					git = true,
					modified = true,
					hidden = false,
					diagnostics = true,
					bookmarks = true,
				},
			},
		},
	},
	keys = {
		{ ",T", "<cmd>NvimTreeFindFileToggle<CR>", mode = { "n", "v", "i", "t" }, silent = true },
	},
}

return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	opts = {
		theme = "hyper",
		config = {
			-- https://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=NeoVim
			header = {
				" ",
				"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
				"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
				"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
				"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
				"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
				"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
				" ",
				string.format("                      %s                       ", require("core.utils").version),
				" ",
			},
			shortcut = {
				{ desc = "[  Github]", group = "DashboardShortCut" },
				{ desc = "[  K5087]", group = "DashboardShortCut" },
				{ desc = "[  0.0.1]", group = "DashboardShortCut" },
			},
			packages = { enable = false },
			center = {
				{
					icon = "  ",
					desc = "Lazy Profile",
					action = "Lazy profile",
				},
				{
					icon = "  ",
					desc = "Edit preferences   ",
					action = string.format("edit %s/lua/custom/init.lua", config_root),
				},
				{
					icon = "  ",
					desc = "Mason",
					action = "Mason",
				},
				-- {
				-- 	icon = "  ",
				-- 	desc = "About IceNvim",
				-- 	action = "IceAbout",
				-- },
			},
			footer = { "work hard,and enjoy coding with vim start screen" },
		},
	},
	config = function(_, opts)
		require("dashboard").setup(opts)

		-- if vim.api.nvim_buf_get_name(0) == "" then
		-- 	vim.cmd("Dashboard")
		-- end

		-- Use the highlight command to replace instead of overriding the original highlight group
		-- Much more convenient than using vim.api.nvim_set_hl()
		-- vim.cmd("highlight DashboardFooter cterm=NONE gui=NONE")
	end,
}

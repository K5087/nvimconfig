return {
	"nvimdev/dashboard-nvim",
	event = "UIEnter",
	opts = {
		theme = "hyper",
		letter_list = "abcdefimnopqrstuvwxyz",
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
				-- string.format("                      %s                       ", require("core.utils").version),
				" ",
			},
			weak_header = {
				enable = false,
			},
			packages = { enable = false },
			shortcut = {
				{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
				{
					icon = " ",
					icon_hl = "@variable",
					desc = "Files",
					group = "Label",
					action = "Telescope find_files",
					key = "f",
				},
				{
					desc = " Apps",
					group = "DiagnosticHint",
					action = "Telescope app",
					key = "a",
				},
				{
					desc = " dotfiles",
					group = "Number",
					action = "Telescope dotfiles",
					key = "d",
				},
			},
			project = { enable = true, limit = 2 },
			mru = { enable = true, limit = 5 },

			-- center = {
			-- 	{
			-- 		icon = "  ",
			-- 		desc = "Lazy Profile",
			-- 		action = "Lazy profile",
			-- 	},
			-- 	{
			-- 		icon = "  ",
			-- 		desc = "Edit preferences   ",
			-- 		action = string.format("edit %s/init.lua", vim.fn.stdpath("config")),
			-- 	},
			-- 	{
			-- 		icon = "  ",
			-- 		desc = "Mason",
			-- 		action = "Mason",
			-- 	},
			-- 	-- {
			-- 	-- 	icon = "  ",
			-- 	-- 	desc = "About IceNvim",
			-- 	-- 	action = "IceAbout",
			-- 	-- },
			-- },
			footer = function()
				local footer_list = {
					"世界乃生死的花园",
					"命运即为人所共愿",
				}
				return { footer_list[math.random(1, #footer_list)] }
			end,
			vertical_center = true,
		},
	},
	config = function(_, opts)
		require("dashboard").setup(opts)
		local shada = vim.fn.stdpath("state") .. "/shada/main.shada"
		vim.o.shadafile = shada
		vim.api.nvim_command("rshada! " .. shada)
		-- if vim.api.nvim_buf_get_name(0) == "" then
		-- 	vim.cmd("Dashboard")
		-- end

		-- Use the highlight command to replace instead of overriding the original highlight group
		-- Much more convenient than using vim.api.nvim_set_hl()
		-- vim.cmd("highlight DashboardFooter cterm=NONE gui=NONE")
	end,
}

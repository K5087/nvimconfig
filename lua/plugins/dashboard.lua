return {
	"nvimdev/dashboard-nvim",
	event = "UIEnter",
	opts = {
		theme = "hyper",
		letter_list = "bdefimnopqrstuvwxyz",
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
					desc = " config",
					group = "Number",
					action = function()
						-- 启用vimlua的额外路径解析
						vim.cmd("VimDev")

						local path = vim.fn.stdpath("config")
						vim.fn.chdir(path)
						path = path .. "/init.lua"
						local buf = vim.fn.bufadd(path)
						vim.fn.bufload(buf)
						vim.api.nvim_set_current_buf(buf)
					end,
					key = "c",
				},
			},
			project = { enable = true, limit = 2 },
			mru = { enable = true, limit = 5 },
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
}

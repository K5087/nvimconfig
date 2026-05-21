vim.pack.add({
	{ src = "https://github.com/folke/snacks.nvim" },
})

local snacks = require("snacks")
local opts = {
	bigfile = { enabled = true },
	dashboard = { enabled = false },
	explorer = { enabled = true },
	indent = { enabled = true },
	input = { enabled = true },
	notifier = {
		enabled = true,
		timeout = 3000,
	},
	picker = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
	styles = {
		notification = {
			-- wo = { wrap = true } -- Wrap notifications
		},
	},
}
snacks.setup(opts)
local set = vim.keymap.set
-- stylua: ignore start
-- Top Pickers & Explorer
set({ "n", "v" }, "<leader><space>", function() snacks.picker.smart() end, {desc = "Smart Find Files"})
set({ "n", "v" }, "<leader>,", function() snacks.picker.buffers() end, {desc = "Buffers"})
set({ "n", "v" }, "<leader>/", function() snacks.picker.grep() end, {desc = "Grep"})
set({ "n", "v" }, "<leader>:", function() snacks.picker.command_history() end, {desc = "Command History"})
set({ "n", "v" }, "<leader>n", function() snacks.picker.notifications() end, {desc = "Notification History"})
set({ "n", "v" }, "<leader>e", function() snacks.explorer() end, {desc = "File Explorer"})
-- find
set({ "n", "v" }, "<leader>fb", function() snacks.picker.buffers() end, {desc = "Buffers"})
set({ "n", "v" }, "<leader>fc", function() snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, {desc = "Find Config File"})
set({ "n", "v" }, "<leader>ff", function() snacks.picker.files() end, {desc = "Find Files"})
set({ "n", "v" }, "<leader>fg", function() snacks.picker.git_files() end, {desc = "Find Git Files"})
set({ "n", "v" }, "<leader>fp", function() snacks.picker.projects() end, {desc = "Projects"})
set({ "n", "v" }, "<leader>fr", function() snacks.picker.recent() end, {desc = "Recent"})
-- git
set({ "n", "v" }, "<leader>gb", function() snacks.picker.git_branches() end, {desc = "Git Branches"})
set({ "n", "v" }, "<leader>gl", function() snacks.picker.git_log() end, {desc = "Git Log"})
set({ "n", "v" }, "<leader>gL", function() snacks.picker.git_log_line() end, {desc = "Git Log Line"})
set({ "n", "v" }, "<leader>gs", function() snacks.picker.git_status() end, {desc = "Git Status"})
set({ "n", "v" }, "<leader>gS", function() snacks.picker.git_stash() end, {desc = "Git Stash"})
set({ "n", "v" }, "<leader>gd", function() snacks.picker.git_diff() end, {desc = "Git Diff (Hunks)"})
set({ "n", "v" }, "<leader>gf", function() snacks.picker.git_log_file() end, {desc = "Git Log File"})
-- gh
set({ "n", "v" }, "<leader>gi", function() snacks.picker.gh_issue() end, {desc = "GitHub Issues (open)"})
set({ "n", "v" }, "<leader>gI", function() snacks.picker.gh_issue({ state = "all" }) end, {desc = "GitHub Issues (all)"})
set({ "n", "v" }, "<leader>gp", function() snacks.picker.gh_pr() end, {desc = "GitHub Pull Requests (open)"})
set({ "n", "v" }, "<leader>gP", function() snacks.picker.gh_pr({ state = "all" }) end, {desc = "GitHub Pull Requests (all)"})
-- Grep
set({ "n", "v" }, "<leader>sb", function() snacks.picker.lines() end, {desc = "Buffer Lines"})
set({ "n", "v" }, "<leader>sB", function() snacks.picker.grep_buffers() end, {desc = "Grep Open Buffers"})
set({ "n", "v" }, "<leader>sg", function() snacks.picker.grep() end, {desc = "Grep"})
set({ "n", "x" }, "<leader>sw", function() snacks.picker.grep_word() end, {desc = "Visual selection or word"})
-- search
set({ "n", "v" }, '<leader>s"', function() snacks.picker.registers() end, {desc = "Registers"})
set({ "n", "v" }, '<leader>s/', function() snacks.picker.search_history() end, {desc = "Search History"})
set({ "n", "v" }, "<leader>sa", function() snacks.picker.autocmds() end, {desc = "Autocmds"})
set({ "n", "v" }, "<leader>sb", function() snacks.picker.lines() end, {desc = "Buffer Lines"})
set({ "n", "v" }, "<leader>sc", function() snacks.picker.command_history() end, {desc = "Command History"})
set({ "n", "v" }, "<leader>sC", function() snacks.picker.commands() end, {desc = "Commands"})
set({ "n", "v" }, "<leader>sd", function() snacks.picker.diagnostics() end, {desc = "Diagnostics"})
set({ "n", "v" }, "<leader>sD", function() snacks.picker.diagnostics_buffer() end, {desc = "Buffer Diagnostics"})
set({ "n", "v" }, "<leader>sh", function() snacks.picker.help() end, {desc = "Help Pages"})
set({ "n", "v" }, "<leader>sH", function() snacks.picker.highlights() end, {desc = "Highlights"})
set({ "n", "v" }, "<leader>si", function() snacks.picker.icons() end, {desc = "Icons"})
set({ "n", "v" }, "<leader>sj", function() snacks.picker.jumps() end, {desc = "Jumps"})
set({ "n", "v" }, "<leader>sk", function() snacks.picker.keymaps() end, {desc = "Keymaps"})
set({ "n", "v" }, "<leader>sl", function() snacks.picker.loclist() end, {desc = "Location List"})
set({ "n", "v" }, "<leader>sm", function() snacks.picker.marks() end, {desc = "Marks"})
set({ "n", "v" }, "<leader>sM", function() snacks.picker.man() end, {desc = "Man Pages"})
set({ "n", "v" }, "<leader>sp", function() snacks.picker.lazy() end, {desc = "Search for Plugin Spec"})
set({ "n", "v" }, "<leader>sq", function() snacks.picker.qflist() end, {desc = "Quickfix List"})
set({ "n", "v" }, "<leader>sR", function() snacks.picker.resume() end, {desc = "Resume"})
set({ "n", "v" }, "<leader>su", function() snacks.picker.undo() end, {desc = "Undo History"})
set({ "n", "v" }, "<leader>uC", function() snacks.picker.colorschemes() end, {desc = "Colorschemes"})
-- LSP
set({ "n", "v" }, "gd", function() snacks.picker.lsp_definitions() end, {desc = "Goto Definition"})
set({ "n", "v" }, "gD", function() snacks.picker.lsp_declarations() end, {desc = "Goto Declaration"})
set({ "n", "v" }, "gr", function() snacks.picker.lsp_references() end,  {nowait = true,desc = "References"})
set({ "n", "v" }, "gI", function() snacks.picker.lsp_implementations() end, {desc = "Goto Implementation"})
set({ "n", "v" }, "gy", function() snacks.picker.lsp_type_definitions() end, {desc = "Goto T[y]pe Definition"})
set({ "n", "v" }, "gai", function() snacks.picker.lsp_incoming_calls() end, {desc = "C[a]lls Incoming"})
set({ "n", "v" }, "gao", function() snacks.picker.lsp_outgoing_calls() end, {desc = "C[a]lls Outgoing"})
set({ "n", "v" }, "<leader>ss", function() snacks.picker.lsp_symbols() end, {desc = "LSP Symbols"})
set({ "n", "v" }, "<leader>sS", function() snacks.picker.lsp_workspace_symbols() end, {desc = "LSP Workspace Symbols"})
-- Other
set({ "n", "v" }, "<leader>z",  function() snacks.zen() end, {desc = "Toggle Zen Mode"})
set({ "n", "v" }, "<leader>Z",  function() snacks.zen.zoom() end, {desc = "Toggle Zoom"})
set({ "n", "v" }, "<leader>.",  function() snacks.scratch() end, {desc = "Toggle Scratch Buffer"})
set({ "n", "v" }, "<leader>S",  function() snacks.scratch.select() end, {desc = "Select Scratch Buffer"})
set({ "n", "v" }, "<leader>n",  function() snacks.notifier.show_history() end, {desc = "Notification History"})
set({ "n", "v" }, "<leader>bd", function() snacks.bufdelete() end, {desc = "Delete Buffer"})
set({ "n", "v" }, "<leader>cR", function() snacks.rename.rename_file() end, {desc = "Rename File"})
set({ "n", "v" }, "<leader>gB", function() snacks.gitbrowse() end, {desc = "Git Browse"})
set({ "n", "v" }, "<leader>gg", function() snacks.lazygit() end, {desc = "Lazygit"})
set({ "n", "v" }, "<leader>un", function() snacks.notifier.hide() end, {desc = "Dismiss All Notifications"})
set({"n","v","t"}, "<c-/>",      function() snacks.terminal() end, {desc = "Toggle Terminal"})
set({ "n", "v" }, "<c-_>",      function() snacks.terminal() end, {desc = "which_key_ignore"})
set({ "n", "v" }, "]]",         function() snacks.words.jump(vim.v.count1) end, {desc = "Next Reference"})
set({ "n", "v" }, "[[",         function() snacks.words.jump(-vim.v.count1) end, {desc = "Prev Reference"})
-- stylua: ignore end
set({ "n", "v" }, "<leader>N", function()
	snacks.win({
		file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
		width = 0.6,
		height = 0.6,
		wo = {
			spell = false,
			wrap = false,
			signcolumn = "yes",
			statuscolumn = " ",
			conceallevel = 3,
		},
	})
end, { desc = "Neovim News" })

return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5 && "
				.. "cmake --build build --config Release && "
				.. "cmake --install build --prefix build",
		},
	},
	-- event = "VeryLazy",
	cmd = "Telescope",
	opts = {
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		-- telescope.load_extension("fzf")
		-- telescope.load_extension("aerial")

		-- 查找本文件中所有动态编译报错
		-- vim.keymap.set("n", "<leader>q", "<cmd>Telescope quickfix<CR>")

		-- 模糊查询
		-- vim.keymap.set({"v", "n"}, "<leader><leader>", "<cmd>FzfLua<CR>", { silent = true, desc = "Fuzzy Find" })
	end,
	keys = {
		-- 查找文件
		{ "<leader>ff", "<cmd>Telescope find_files initial_mode=insert<CR>", desc = "Find files" },

		-- 查找文件（仅包含 CMake 目标所直接包含的源和头文件）
		{
			"<leader>fp",
			"<cmd>Telescope cmake_tools sources initial_mode=insert<CR>",
			desc = "Find CMake target sources",
		},

		-- 查找文件（仅包含 CMakeLists.txt 和 *.cmake 类文件）
		{
			"<leader>fc",
			"<cmd>Telescope cmake_tools cmake_files initial_mode=insert<CR>",
			desc = "Find CMake files",
		},

		-- 查找 git 仓库中的文件
		{ "<leader>fg", "<cmd>Telescope git_files initial_mode=insert<CR>", desc = "Find git files" },

		-- 查找最近打开过的文件
		{ "<leader>fr", "<cmd>Telescope oldfiles initial_mode=insert<CR>", desc = "Recent files" },

		-- 查找 git status 中的文件
		{ "<leader>gs", "<cmd>Telescope git_status initial_mode=insert<CR>", desc = "Git status" },

		-- 查找当前项目文件中的文本
		{ "<leader>sg", "<cmd>Telescope live_grep initial_mode=insert<CR>", desc = "Live grep" },

		-- 查找所有已打开文件
		{ "<leader>sb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },

		-- 查找当前 Tab 中所有已打开文件
		{ "<leader>st", "<cmd>Telescope scope buffers<CR>", desc = "Tab buffers" },

		-- 查找 vim 的跳转记录
		{ "<leader>sj", "<cmd>Telescope jumplist initial_mode=insert<CR>", desc = "Jumplist" },

		-- 查找 vim 的标记
		{ "<leader>sm", "<cmd>Telescope marks initial_mode=insert<CR>", desc = "Marks" },

		-- 查找 / 的搜索记录
		{ "<leader>/", "<cmd>Telescope search_history initial_mode=insert<CR>", desc = "Search history" },

		-- 查找 vim 命令历史记录
		{ "<leader>:", "<cmd>Telescope command_history initial_mode=insert<CR>", desc = "Command history" },

		-- 查找所有 vim 命令
		{ "<leader>;", "<cmd>Telescope commands initial_mode=insert<CR>", desc = "Commands" },

		-- 查找帮助文档
		{ "<leader>?", "<cmd>Telescope help_tags initial_mode=insert<CR>", desc = "Help tags" },

		-- 查找本文件中所有文本对象
		{ "<leader>z", "<cmd>Telescope treesitter initial_mode=insert<CR>", desc = "Treesitter symbols" },

		-- 查找本文件中所有符号
		{
			"<leader>x",
			"<cmd>Telescope lsp_document_symbols initial_mode=insert<CR>",
			desc = "Document symbols",
		},

		-- 查找 git 仓库的 commit 历史
		{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git commits" },

		-- 查找 git 仓库的所有分支
		{ "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Git branches" },

		-- 查找本文件中所有静态分析报错
		{ "<leader>a", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },

		-- 查看所有 Vim 通知
		{ "<leader>n", "<cmd>Telescope notify<CR>", desc = "Notifications" },

		-- 恢复上一次 Telescope
		{ "<leader>r", "<cmd>Telescope resume<CR>", mode = { "n", "v" }, desc = "Resume Telescope" },
	},
}

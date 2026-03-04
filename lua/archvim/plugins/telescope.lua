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
		telescope.load_extension("fzf")
		telescope.load_extension("aerial")

		-- 查找文件
		vim.keymap.set("n", "<leader>fd", "<cmd>Telescope find_files initial_mode=insert<CR>")
		-- 查找文件（仅包含 CMake 目标所直接包含的源和头文件）
		vim.keymap.set("n", "<leader>cs", "<cmd>Telescope cmake_tools sources initial_mode=insert<CR>")
		-- 查找文件（仅包含 CMakeLists.txt 和 *.cmake 类文件）
		vim.keymap.set("n", "<leader>cf", "<cmd>Telescope cmake_tools cmake_files initial_mode=insert<CR>")
		-- 查找 git 仓库中的文件
		vim.keymap.set("n", "<leader>g", "<cmd>Telescope git_files initial_mode=insert<CR>")
		-- 查找最近打开过的文件
		vim.keymap.set("n", "<leader>o", "<cmd>Telescope oldfiles initial_mode=insert<CR>")
		-- 查找 git status 中的文件
		vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status initial_mode=insert<CR>")
		-- 查找当前项目文件中的文字
		vim.keymap.set("n", "<leader>ip", "<cmd>Telescope live_grep initial_mode=insert<CR>")
		-- 查找所有已打开文件
		vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<CR>")
		-- 查找当前 Tab 中所有已打开文件
		vim.keymap.set("n", "<leader>B", "<cmd>Telescope scope buffers<CR>")
		-- 查找 vim 的跳转记录
		vim.keymap.set("n", "<leader>j", "<cmd>Telescope jumplist initial_mode=insert<CR>")
		-- 查找 vim 的标记
		vim.keymap.set("n", "<leader>m", "<cmd>Telescope marks initial_mode=insert<CR>")
		-- 查找 / 的搜索记录
		vim.keymap.set("n", "<leader>/", "<cmd>Telescope search_history initial_mode=insert<CR>")
		-- 查找 vim 命令历史记录
		vim.keymap.set("n", "<leader>:", "<cmd>Telescope command_history initial_mode=insert<CR>")
		-- 查找所有 vim 命令
		vim.keymap.set("n", "<leader>;", "<cmd>Telescope commands initial_mode=insert<CR>")
		-- 查找帮助文档
		vim.keymap.set("n", "<leader>?", "<cmd>Telescope help_tags initial_mode=insert<CR>")
		if pcall(require, "todo-comments") then
			-- 查找 todo 等事项
			vim.keymap.set("n", "<leader>t", "<cmd>TodoTelescope initial_mode=insert<CR>")
		end
		-- 查找本文件中所有文本对象
		vim.keymap.set("n", "<leader>z", "<cmd>Telescope treesitter initial_mode=insert<CR>")
		-- 查找本文件中所有符号
		vim.keymap.set("n", "<leader>x", "<cmd>Telescope lsp_document_symbols initial_mode=insert<CR>")
		-- 查找 git 仓库的 commit 历史
		vim.keymap.set("n", "<leader>c", "<cmd>Telescope git_commits<CR>")
		-- 查找 git 仓库的所有分支
		vim.keymap.set("n", "<leader>v", "<cmd>Telescope git_branches<CR>")
		-- 查找本文件中所有静态分析报错
		vim.keymap.set("n", "<leader>a", "<cmd>Telescope diagnostics<CR>")
		-- 查找本文件中所有动态编译报错
		vim.keymap.set("n", "<leader>q", "<cmd>Telescope quickfix<CR>")
		-- 查看所有 Vim 通知
		vim.keymap.set("n", "<leader>n", "<cmd>Telescope notify<CR>")
		-- 模糊查询
		-- vim.keymap.set({"v", "n"}, "<leader><leader>", "<cmd>FzfLua<CR>", { silent = true, desc = "Fuzzy Find" })
		vim.keymap.set({ "v", "n" }, "<leader><leader>", "<cmd>Telescope resume<CR>")
	end,
}

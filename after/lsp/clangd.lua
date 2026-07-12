---@type vim.lsp.Config
return {
	-- cmd = { "clangd", "--clang-tidy", "--header-insertion=never", "--completion-style=detailed" },
	cmd = {
		"clangd",
		"--clang-tidy", -- 进行一些额外检查和建议
		"--background-index", -- 开启后台索引(用于避免每次打开全量重建)
		"--header-insertion=never", -- 不自动插入头文件
		"--experimental-modules-support", -- 开启模块支持(在某些情况下clangd会构建自己的bmi进行索引)
		"--compile-commands-dir=build", --指定clangd自己的构建目录
	},
}

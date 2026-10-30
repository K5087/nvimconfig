local cmd = {
	"clangd",
	"--clang-tidy", -- 进行一些额外检查和建议
	"--background-index", -- 开启后台索引(用于避免每次打开全量重建)
	"--header-insertion=never", -- 不自动插入头文件
	"--experimental-modules-support", -- 开启模块支持(在某些情况下clangd会构建自己的bmi进行索引)
	"--log=verbose", -- 打印日志,排查错误信息
}
local function find_database(path)
	local file = vim.fn.findfile("compile_commands.json", path)
	if #file ~= 0 then
		return true, file
	else
		return false, nil
	end
end

local erro, file = find_database(".;")
if not erro then
	erro, file = find_database("./build")
end
if erro then
	table.insert(cmd, "--compile-commands-dir=" .. vim.fs.dirname(file))
end

---@type vim.lsp.Config
return {
	-- cmd = { "clangd", "--clang-tidy", "--header-insertion=never", "--completion-style=detailed" },
	cmd = cmd,
}

local version = vim.fn.matchstr(vim.fn.execute("version"), "NVIM v\\zs[^\\n]*")

local function check_cmake_project()
	return vim.fn.findfile("CMakeLists.txt", ".;") ~= ""
end

local utils = {
	version = version,

	is_linux = vim.uv.os_uname().sysname == "Linux",
	is_mac = vim.uv.os_uname().sysname == "Darwin",
	is_windows = vim.uv.os_uname().sysname == "Windows_NT",
	is_wsl = string.find(vim.uv.os_uname().release, "WSL") ~= nil,

	is_cmake_project = check_cmake_project(),
}

-- 为CMake项目创建一个命令组
local cmake_group = vim.api.nvim_create_augroup("CMakeEvents", { clear = true })
-- 为CMake项目创建一个事件
vim.api.nvim_create_autocmd({ "User" }, {
	group = cmake_group,
	pattern = "CMakeProject",
	callback = function() end,
})

-- 为Utils创建一个命令组
local utils_group = vim.api.nvim_create_augroup("utils_upate", { clear = true })

vim.api.nvim_create_autocmd("DirChanged", {
	group = utils_group,
	callback = function()
		utils.is_cmake_project = check_cmake_project()
		if not utils.is_cmake_project then
			return
		end
		local cmake_list = vim.fn.findfile("CMakeLists.txt", ".;")
		local path = vim.fn.fnamemodify(cmake_list, ":p:h")
        vim.notify("is i do?")
		vim.api.nvim_exec_autocmds("User", { pattern = "CMakeProject", data = path })
	end,
})

return utils

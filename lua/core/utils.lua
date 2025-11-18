local version = vim.fn.matchstr(vim.fn.execute("version"), "NVIM v\\zs[^\\n]*")

-- 为CMake项目创建一个命令组
local cmake_group = vim.api.nvim_create_augroup("CMakeEvents", { clear = true })
-- 为CMake项目创建一个事件
vim.api.nvim_create_autocmd({ "User" }, {
	group = cmake_group,
	pattern = "CMakeProject",
	callback = function() end,
})

local utils = {
	version = version,

	is_linux = vim.uv.os_uname().sysname == "Linux",
	is_mac = vim.uv.os_uname().sysname == "Darwin",
	is_windows = vim.uv.os_uname().sysname == "Windows_NT",
	is_wsl = string.find(vim.uv.os_uname().release, "WSL") ~= nil,

	is_cmake_project = false,
	is_window_suit = vim.fn.winwidth(0) > 50,
}

function utils:check_cmake_project()
	local cmake_file = vim.fn.findfile("CMakeLists.txt", ".;")
	utils.is_cmake_project = cmake_file ~= ""
	if not utils.is_cmake_project then
		if utils.project_set_cancel then
			utils.project_set_cancel()
			utils.project_set_cancel = nil
		end
		return
	end
	local path = vim.fn.fnamemodify(cmake_file, ":p:h")
	vim.api.nvim_exec_autocmds("User", { pattern = "CMakeProject", data = path })
end

-- 为Utils创建一个命令组
local utils_group = vim.api.nvim_create_augroup("utils_upate", { clear = true })

vim.api.nvim_create_autocmd("DirChanged", {
	group = utils_group,
	callback = utils.check_cmake_project,
})

local suitwindow_update_event = { "VimResized", "BufEnter" }
for _, event in ipairs(suitwindow_update_event) do
	vim.api.nvim_create_autocmd(event, {
		group = utils_group,
		callback = function()
			utils.is_window_suit = vim.fn.winwidth(0) > 50
		end,
	})
end

return utils

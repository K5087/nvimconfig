local version = vim.fn.matchstr(vim.fn.execute "version", "NVIM v\\zs[^\\n]*")
local utils = {
    is_linux = vim.uv.os_uname().sysname == "Linux",
    is_mac = vim.uv.os_uname().sysname == "Darwin",
    is_windows = vim.uv.os_uname().sysname == "Windows_NT",
    is_wsl = string.find(vim.uv.os_uname().release, "WSL") ~= nil,
    version = version,
}
return utils

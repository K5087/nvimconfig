-- leader键
vim.g.mapleader = ","

-- 行号
vim.opt.number = true
vim.opt.relativenumber = true

-- 设置符号列占用行号
vim.opt.signcolumn = "number"

-- 高亮当前行
vim.opt.cursorline = true

-- 将tab转换为空格,tab为4字符,行开头的tab与默认tab设置相同
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0

-- 将"寄存器与+寄存器绑定
vim.opt.clipboard = "unnamed,unnamedplus"

-- 文件被外部程序修改后自动重新加载
vim.opt.autoread = true

-- 在下方和右侧进行分屏
vim.opt.splitbelow = true
vim.opt.splitright = true

-- 如果查找的内容中不存在大写，则大小写不敏感
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- 将vim设置为24位颜色
vim.opt.termguicolors = true

-- 将shell设置为nushell
if vim.fn.executable("nu") then
	vim.opt.shell = "nu"
end

-- netrw设置
-- 隐藏以点开头的文件
vim.g.netrw_list_hide = [[\(^\|\s\s\)\zs\.\S\+]]

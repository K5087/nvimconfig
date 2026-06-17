local opt = vim.opt

-- leader键
vim.g.mapleader = " "

-- 行号
opt.number = true
opt.relativenumber = true

-- 设置符号列占用行号
opt.signcolumn = "number"

-- 高亮当前行
opt.cursorline = true

-- 保持当前行距离窗口顶部或底部10行, 当前列距离窗口左边或右边8列
opt.scrolloff = 10
opt.sidescrolloff = 8

-- 将tab转换为空格,tab为4字符,行开头的tab与默认tab设置相同
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 0

-- 将"寄存器与+寄存器绑定
opt.clipboard = vim.env.SSH_TTY and "" or "unnamed,unnamedplus"

-- 文件被外部程序修改后自动重新加载
opt.autoread = true

-- 禁止创建交换文件
opt.swapfile = false

-- 在下方和右侧进行分屏
opt.splitbelow = true
opt.splitright = true

-- 如果查找的内容中不存在大写，则大小写不敏感
opt.ignorecase = true
opt.smartcase = true

-- 取消匹配高亮
-- opt.hlsearch = false

-- 替换fold char
opt.fillchars = { foldopen = " ", foldclose = " ", fold = " ", foldsep = " ", diff = "╱", eob = " " }

-- 将vim设置为24位颜色
opt.termguicolors = true

-- 将shell设置为nushell
-- if vim.fn.executable("nu") then
-- 	opt.shell = "nu"
-- 	opt.shellcmdflag = "-c"
-- 	opt.shellquote = ""
-- 	opt.shellxquote = ""
-- end

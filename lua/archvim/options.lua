vim.g.mapleader = ","

-- 行号
vim.opt.number = true
vim.opt.relativenumber = true

-- 高亮当前行
vim.opt.cursorline = true

-- 将tab转换为空格,tab为4字符,行开头的tab与默认tab设置相同
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0

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

-- 在进入命令行后才读取历史信息文件(shada)
vim.opt.shadafile = "NONE"
-- vim.api.nvim_create_autocmd("CmdlineEnter", {
--     once = true,
--     callback = function()
--         local shada = vim.fn.stdpath("state") .. "/shada/main.shada"
--         vim.o.shadafile = shada
--         vim.api.nvim_command("rshada! " .. shada)
--     end,
-- })

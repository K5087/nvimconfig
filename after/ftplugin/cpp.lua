-- 取消(当前行是注释时)按下回车会添加注释
vim.opt_local.formatoptions:remove({ "r", "c", "o" })

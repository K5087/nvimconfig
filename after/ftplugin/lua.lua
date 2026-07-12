-- 取消(当前行是注释时)按下回车会添加注释
vim.opt_local.formatoptions:remove("r")
vim.opt_local.formatoptions:remove("c")
vim.opt_local.formatoptions:remove("o")

return {
	-- rumdl默认没有表格对齐,这里开启
	cmd = {
		"rumdl",
		"--config",
		vim.fn.stdpath("config") .. "/lua/config/.rumdl.toml",
		"server",
	},
}

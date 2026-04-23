vim.pack.add({
	{ src = "https://github.com/smoka7/hop.nvim" },
})

vim.api.nvim_create_autocmd("BufEnter", {
	once = true,
	callback = function()
		local hop = require("hop")
		hop.setup({ keys = "etovxqpdygfblzhckisuran" })
		vim.keymap.set({ "n", "v" }, "<leader><Space>", function()
			hop.hint_char1({ current_line_only = false })
		end, { remap = true })
	end,
})

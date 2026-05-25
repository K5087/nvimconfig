vim.api.nvim_create_user_command("Moke", require("cfcc").check_func_sign, { desc = "test functions" })
local function Test()
	local params = vim.lsp.util.make_position_params(0, "utf-16")

	vim.lsp.buf_request(0, "textDocument/typeDefinition", params, function(err, result, ctx, config)
		if err then
			vim.notify(vim.inspect(err), vim.log.levels.ERROR)
			return
		end

		print(vim.inspect(result))
	end)
end

vim.api.nvim_create_user_command("Test", Test, { desc = "test functions" })

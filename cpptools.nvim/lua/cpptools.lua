local M = {}
local lsp = require("cpptools.lsp")
local ast = require("cpptools.ast")

function M.check_func_sign()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "clangd" })
	if #clients < 1 then
		vim.notify("cannot find clangd client")
		return
	end

	local clangd_client = clients[1]

	local node = vim.treesitter.get_node({ bufnr = bufnr })
	if not node then
		vim.notify("current cursor have no treesitter node")
		return
	end

	local info = ast.GetFunctionSign(node)
	if not info then
		vim.notify("cannot find function signature")
		return
	end

	-- local text = ast.node_text(info.function_declarator, bufnr)
	lsp.edit_target(bufnr, clangd_client, M.handle_requrest)
end

--- handle request
---@param request RequestInfo
function M.handle_requrest(request)
	local func_nodes =
		ast.search_function(request.to, { bufnr = request.from, node = request.info.function_declarator })
	vim.print(ast.node_text(request.from, request.info.function_declarator))
	local message = {}
	for _, node in ipairs(func_nodes) do
		table.insert(message, ast.node_text(request.to, node))
	end
	vim.print(message)
end

return M

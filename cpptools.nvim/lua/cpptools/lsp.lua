local M = {}
local ast = require("cpptools.ast")

---@class RequestInfo
---@field header integer cpp header file buffer id
---@field source integer cpp source file buffer id
---@field info FunctionInfo function ast info
---@field from integer which bufnr launch request
---@field to integer which bufnr should change

---get change param
---@param bufnr integer which bufnr requrest
---@param uri string target file path
---@return RequestInfo?
local function get_sign_param(bufnr, uri)
	local path = vim.uri_to_fname(uri)
	local bufid = vim.fn.bufadd(path)
	if bufid < 0 then
		vim.notify("file" .. "not exist")
		return nil
	end
	vim.fn.bufload(bufid)
	local is_header = M.is_header(vim.api.nvim_buf_get_name(bufnr))

	local node = vim.treesitter.get_node({ bufnr = bufnr })

	if not node then
		vim.notify("cannot find ast node")
		return nil
	end
	local info = ast.GetFunctionSign(node)
	if not info then
		vim.notify("cannot find function signature")
		return nil
	end
	---@type RequestInfo
	local params = {
		header = is_header and bufnr or bufid,
		source = is_header and bufid or bufnr,
		info = info,
		from = bufnr,
		to = bufid,
	}
	return params
end

---check file path whether cpp header
---@param path string file path
---@return boolean
function M.is_header(path)
	local ext = vim.fn.fnamemodify(path, ":e")
	return ext == "h" or ext == "hxx"
end

---write function signature to target file
---@param bufnr integer
---@param client vim.lsp.Client
---@param func function(RequestInfo)
function M.edit_target(bufnr, client, func)
	local method_name = "textDocument/switchSourceHeader"
	---@diagnostic disable-next-line:param-type-mismatch
	if not client or not client:supports_method(method_name) then
		return vim.notify(
			("method %s is not supported by any servers active on the current buffer"):format(method_name)
		)
	end
	local params = vim.lsp.util.make_text_document_params(bufnr)
	---@diagnostic disable-next-line:param-type-mismatch
	client:request(method_name, params, function(err, result)
		if err then
			error(tostring(err))
		end
		if not result then
			vim.notify("corresponding file cannot be determined")
			return
		end

		local param = get_sign_param(bufnr, result)
		func(param)
	end, bufnr)
end

return M

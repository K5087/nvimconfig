local function NodeFieldText(bufnr, node, field)
	return vim.treesitter.get_node_text(node:field(field)[1], bufnr)
end

local function IsHeader(file)
	local ext = vim.fn.expand("%:e")

	return ext == "h" or ext == "hxx"
end

---comment
---@param node TSNode
---@param type string
---@return TSNode?
local function FindTypeNode(node, type)
	---@type TSNode?
	local cnode = node
	while cnode do
		if cnode:type() == type then
			return cnode
		end
		cnode = cnode:parent()
	end
	return nil
end

---@class CppFunctionInfo
---@field function_declarator TSNode
---@field type TSNode
---@field class TSNode?
---@field namespace TSNode?
---@field debug TSNode?

---comment
---@param node TSNode
---@return CppFunctionInfo?
local function GetFunctionSign(node)
	local fnode = FindTypeNode(node, "function_declarator")
	if not fnode then
		return nil
	end

	local info = { function_declarator = fnode }
	local type = fnode:type()

	---@type TSNode?
	local rnode = fnode:parent()
	while rnode ~= nil do
		type = rnode:type()
		if type == "declaration" or type == "field_declaration" or type == "function_definition" then
			info.debug = rnode
			info.type = rnode:field("type")[1]
			rnode = rnode:parent()
			while rnode ~= nil do
				type = rnode:type()
				if type == "namespace_definition" then
					info.namespace = rnode
				elseif type == "class_specifier" or type == "struct_specifier" then
					info.class = rnode
				end
				rnode = rnode:parent()
			end
			break
		end

		rnode = rnode:parent()
	end
	return info
end

---comment
---@param node TSNode
---@param bufnr integer
---@return string
local function node_text(node, bufnr)
	return vim.treesitter.get_node_text(node, bufnr)
end

---comment
---@param node TSNode
---@param field string
---@return TSNode[]
local function child_by_field(node, field) end
---comment
---@param bufnr integer
---@param node TSNode
---@return string?
local function definition_signature_from_ts(bufnr, node)
	local type_node = child_by_field(node, "type")
	local declarator_node = child_by_field(node, "declarator")

	if not declarator_node then
		return nil
	end

	local parts = {}

	if type_node then
		table.insert(parts, node_text(type_node, bufnr))
	end

	table.insert(parts, node_text(declarator_node, bufnr))

	return table.concat(parts, " ")
end

local function MatchFunction(file)
	-- local bufnr = vim.fn.bufadd(file)
	-- if bufnr < 0 then
	-- 	vim.notify(file .. "not exist")
	-- 	return
	-- end
	-- vim.fn.bufload(bufnr)
end

local function EditSourceHeader(bufnr, client, func)
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
		func(result)
		-- vim.cmd.edit(vim.uri_to_fname(result))
	end, bufnr)
end

vim.api.nvim_create_user_command("Moke", function()
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

	local info = GetFunctionSign(node)
	if not info then
		vim.notify("cannot find function signature")
		return
	end

	local text = node_text(info.debug, bufnr)
	local text = node_text(info.function_declarator, bufnr)
	vim.print(text)
	-- EditSourceHeader(bufnr, clangd_client, MatchFunction)
end, { desc = "test cpp plugin" })

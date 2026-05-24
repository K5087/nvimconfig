local M = {}

---Get Node Text
---@param bufnr integer
---@param node TSNode
---@return string
function M.node_text(bufnr, node)
	return vim.treesitter.get_node_text(node, bufnr)
end

--- find parent node that node::type()==type
---@param node TSNode
---@param type string
---@return TSNode?
function M.FindTypeNode(node, type)
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

---@class FunctionInfo
---@field func TSNode
---@field type TSNode
---@field class TSNode?
---@field namespace TSNode?
---@field is_declarator boolean
---@field full TSNode?

---Get current cursor Function Signature
---@param node TSNode
---@return FunctionInfo?
function M.GetFunctionSign(node)
	local info = {}
	local fnode = M.FindTypeNode(node, "function_declarator")
	if node then
		info.is_declarator = true
	else
		fnode = M.FindTypeNode(node, "function_definition")
		if fnode then
			info.is_declarator = false
		else
			return nil
		end
	end

	info.func = fnode
	local type = info.func:type()

	---@type TSNode?
	local rnode = info.func:parent()
	while rnode ~= nil do
		type = rnode:type()
		if type == "function_definition" then
			info.is_declarator = false
		end
		if type == "declaration" or type == "field_declaration" or type == "function_definition" then
			info.full = rnode
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

---@class MatchFuncInfo
---@field name boolean whether function name is equal
---@field params boolean whether function params are equal

---search buffer all function name same
---@param bufnr integer
---@param info NodeInfo
---@return TSNode[]
function M.search_function(bufnr, info)
	local query = vim.treesitter.query.get("cpp", "function_decls")
	if not query then
		vim.notify("can not find function_decl query")
		return {}
	end
	local parser = vim.treesitter.get_parser(bufnr, "cpp")

	if not parser then
		vim.notify("have not find cpp parser")
		return {}
	end

	local tree = parser:parse()[1]

	if not tree then
		return {}
	end
	local root = tree:root()

	local func_nodes = {}
	for _, match in query:iter_matches(root, bufnr, 0, -1) do
		local decl_node
		local name_node

		for id, nodes in ipairs(match) do
			local cap = query.captures[id]
			local node = nodes[1]

			if cap == "func" then
				decl_node = node
			elseif cap == "name" then
				name_node = node
			end
		end

		if decl_node then
			-- local match_info = M.is_function_equal(info, { bufnr = bufnr, node = decl_node })
			-- if match_info.name == true then
			-- 	table.insert(func_nodes, decl_node)
			-- end

			table.insert(func_nodes, decl_node)
		end
	end
	return func_nodes
end

---Get Function Parameter List Node
---@param node TSNode function_declarator
---@return TSNode[]
local function get_function_param_list(node)
	local param_node = node:field("parameters")[1]

	local params = {}
	for child in param_node:iter_children() do
		table.insert(params, child:field("type")[1])
	end
	return params
end

---@class NodeInfo
---@field bufnr integer
---@field node TSNode

---check node text is equal
---@param info1 NodeInfo
---@param info2 NodeInfo
local function is_node_equal(info1, info2)
	return vim.treesitter.get_node_text(info1.node, info1.bufnr)
		== vim.treesitter.get_node_text(info2.node, info2.bufnr)
end

---check weathure tow function_declarator node are equal
---@param info1 NodeInfo function_declarator
---@param info2 NodeInfo function_declarator
---@return MatchFuncInfo
function M.is_function_equal(info1, info2)
	local match_info = {
		name = false,
		params = false,
	}
	local decl_node1 = info1.node:field("declarator")[1]
	local decl_node2 = info2.node:field("declarator")[1]

	if
		is_node_equal({ bufnr = info1.bufnr, node = decl_node1 }, { bufnr = info2.bufnr, node = decl_node2 }) == true
	then
		match_info.name = true
	end

	local params1 = get_function_param_list(info1.node)
	local params2 = get_function_param_list(info2.node)

	if #params1 ~= #params2 then
		return match_info
	end

	for i = 1, #params1 do
		local type_info1 = {
			bufnr = info1.bufnr,
			node = params1[i],
		}
		if not params2[i] then
			match_info.params = false
			break
		end
		local type_info2 = {
			bufnr = info2.bufnr,
			node = params2[i],
		}

		if is_node_equal(type_info1, type_info2) == true then
			match_info.params = true
			break
		end
	end
	return match_info
end

return M

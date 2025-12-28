local utils = require("core.utils")
local cmake = require("cmake-tools")

local cmake_component = {
	kit = {
		function()
			if cmake.has_cmake_preset() then
				local b_preset = cmake.get_build_preset()
				if not b_preset then
					return ""
				end
				return "" .. string.format(" [%s]", b_preset)
			else
				local b_type = cmake.get_build_type()
				if not b_type then
					return ""
				end
				return "" .. string.format(" [%s]", b_type)
			end
		end,
		cond = function()
			return utils.is_window_suit and (vim.bo.buftype == "" or vim.bo.buftype == "quickfix")
		end,
		on_click = function(n, mouse)
			if n == 1 then
				if mouse == "l" then
					cmake.generate({})
				elseif mouse == "r" then
					if cmake.has_cmake_preset() then
						cmake.select_build_preset()
					else
						cmake.select_build_type()
					end
				end
			end
		end,
		color = { bg = "NONE" },
	},
	build = {
		function()
			local b_target = cmake.get_build_target()
			if not b_target or b_target == "all" then
				return ""
			end
			return "" .. string.format(" [%s]", b_target[1])
		end,
		cond = function()
			return utils.is_window_suit and vim.bo.buftype == ""
		end,
		on_click = function(n, mouse)
			if n == 1 then
				if mouse == "l" then
					local b_target = cmake.get_build_target()
					if not b_target then
						local l_target = cmake.get_launch_target()
						if l_target then
							cmake.build({
								target = l_target,
							})
							return
						end
						cmake.build({
							target = "all",
						})
					else
						cmake.build({})
					end
				elseif mouse == "r" then
					cmake.select_build_target()
				end
			end
		end,
		color = { bg = "NONE" },
	},
	debug = {
		function()
			return ""
		end,
		cond = function()
			return utils.is_window_suit and vim.bo.buftype == ""
		end,
		on_click = function(n, mouse)
			if n == 1 then
				if mouse == "l" then
					local l_target = cmake.get_launch_target()
					if not l_target then
						local b_target = cmake.get_build_target()
						if b_target then
							cmake.debug({
								target = b_target,
							})
							return
						end
					end
					cmake.debug({})
				elseif mouse == "r" then
					cmake.select_launch_target()
				end
			end
		end,
	},
	exec = {
		function()
			local l_target = cmake.get_launch_target()
			if not l_target then
				return ""
			end
			return "" .. string.format(" [%s]", l_target)
		end,
		cond = function()
			return utils.is_window_suit and vim.bo.buftype == ""
		end,
		on_click = function(n, mouse)
			if n == 1 then
				if mouse == "l" then
					local l_target = cmake.get_launch_target()
					if not l_target then
						local b_target = cmake.get_build_target()
						if b_target then
							cmake.run({
								target = b_target,
							})
							return
						end
					end
					cmake.run({})
				elseif mouse == "r" then
					cmake.select_launch_target()
				end
			end
		end,
	},
}

local cmake_component_tool = {}
function cmake_component_tool.setup(is_add)
	local lualine = require("lualine")
	local lualine_opt = lualine.get_config()

	if is_add then
		lualine_opt.winbar.lualine_b = { cmake_component.kit, cmake_component.build }
		lualine_opt.winbar.lualine_c = { cmake_component.debug, cmake_component.exec }
	else
		lualine_opt.winbar.lualine_b = {}
		lualine_opt.winbar.lualine_c = {}
	end
	lualine.setup(lualine_opt)
end

return cmake_component_tool

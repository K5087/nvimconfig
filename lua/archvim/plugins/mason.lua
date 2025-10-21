return {
	"mason-org/mason.nvim",
	event = "VeryLazy",
	dependencies = {
		"neovim/nvim-lspconfig",
		"mason-org/mason-lspconfig.nvim",
	},
	opts = {
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	},
	config = function(_, opts)
		require("mason").setup(opts)
		local registry = require("mason-registry")

		local package_list = registry.get_all_package_names()
		if #package_list == 0 then
			registry.refresh()
		end

		-- 检查包是否安装
		local function CheckInstall(package)
			local s, p = pcall(registry.get_package, package)
			if s and not p:is_installed() then
				p:install()
			end
		end

		-- vim设置lsp服务器
		local function setup(name, config)
			-- CheckInstall(name)
			local lsp = require("mason-lspconfig").get_mappings().package_to_lspconfig[name]
			if lsp then
				vim.lsp.config(lsp, config)
			end
		end

		local servers = {
			["lua-language-server"] = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			},
			["clangd"] = { cmd = { "clangd", "--experimental-modules-support" } },
		}

		local installed_package = registry.get_installed_package_names()

		for _, package in ipairs(installed_package) do
			local config = servers[package] or {}
			-- config.capabilities = require("blink.cmp").get_lsp_capabilities()
			local spec = registry.get_package(package).spec.categories
			if vim.tbl_contains(spec, "Formatter") then
				config.on_attach = function(client)
					-- 禁用文档格式化和选中范围格式化(针对当前lsp)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end
			end
			setup(package, config)
		end

		local function lsp_start()
			-- Do not directly call `LspStart` (although the code below is pretty much word-to-word copied from the command)
			-- The reason is that `LspStart` would raise an error if no matching server is configured. This becomes an issue
			-- when the first file we open does not have a matching server. Therefore, we gotta check whether a server
			-- exists first.
			local servers_name = {}
			local filetype = vim.bo.filetype
			---@diagnostic disable-next-line: invisible
			for name, _ in pairs(vim.lsp.config._configs) do
				local filetypes = vim.lsp.config[name].filetypes
				if filetypes and vim.tbl_contains(filetypes, filetype) then
					table.insert(servers_name, name)
				end
			end

			if #servers_name > 0 then
				vim.lsp.enable(servers_name)
			end
		end

		local augroup = vim.api.nvim_create_augroup("LspGroup", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			group = augroup,
			callback = lsp_start,
		})

		-- 当使用nvim第一次打开文件时,lsp服务还没加载,这里需要手动加载一下
		lsp_start()

		vim.diagnostic.config({
			virtual_text = true,
			update_in_insert = true,
		})
	end,
}

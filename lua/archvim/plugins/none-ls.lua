return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
    ft = {"h","c","hpp","cpp","lua","json","md"},
	-- event = "VeryLazy",
	config = function()
		local registry = require("mason-registry")

		local function CheckInstall(name)
			local success, package = pcall(registry.get_package, name)
			if success and not package:is_installed() then
				package:install()
			end
		end

		CheckInstall("stylua")
		CheckInstall("clang-format")
		CheckInstall("jq")

		local null_ls = require("null-ls")
		local helpers = require("null-ls.helpers")
		local jq_formatter = {
			name = "jq",
			method = null_ls.methods.FORMATTING,
			filetypes = { "json" },
			generator = helpers.formatter_factory({
				command = "jq",
				args = { "." },
				to_stdin = true,
			}),
		}
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.clang_format,
				jq_formatter,
			},
		})
	end,
	keys = { {
		"g=",
		function()
			vim.lsp.buf.format()
		end,
	} },
}

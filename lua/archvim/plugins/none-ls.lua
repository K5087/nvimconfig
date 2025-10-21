return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	ft = { "h", "c", "hpp", "cpp", "lua", "json", "md" },
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
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		local async_formatting = function(bufnr)
			bufnr = bufnr or vim.api.nvim_get_current_buf()

			vim.lsp.buf_request(
				bufnr,
				"textDocument/formatting",
				vim.lsp.util.make_formatting_params({}),
				function(err, res, ctx)
					if err then
						local err_msg = type(err) == "string" and err or err.message
						-- you can modify the log message / level (or ignore it completely)
						vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
						return
					end

					-- don't apply results if buffer is unloaded or has been modified
					if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
						return
					end

					if res then
						local client = vim.lsp.get_client_by_id(ctx.client_id)
						vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
						vim.api.nvim_buf_call(bufnr, function()
							vim.cmd("silent noautocmd update")
						end)
					end
				end
			)
		end
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.clang_format,
				jq_formatter,
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePost", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							async_formatting(bufnr)
						end,
					})
				end
			end,
		})
	end,
	keys = { {
		"g=",
		function()
			vim.lsp.buf.format()
		end,
	} },
}

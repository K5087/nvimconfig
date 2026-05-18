return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "BufWinEnter",
	config = function()
		require("bufferline").setup({
			options = {
				buffer_close_icon = "x",
				modified_icon = "*",
				left_trunc_marker = "<",
				right_trunc_marker = ">",
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						highlight = "Directory",
						text_align = "left",
					},
				},
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count)
					return "(" .. count .. ")"
				end,
				sort_by = "insert_after_current",
				custom_filter = function(buf_number)
					if vim.bo[buf_number].filetype == "qf" then
						return false
					end
					if vim.bo[buf_number].buftype == "terminal" then
						return false
					end
					if vim.bo[buf_number].buftype == "nofile" then
						return false
					end
					if vim.bo[buf_number].filetype == "Trouble" then
						return false
					end
					return true
				end,
			},
		})
	end,

	keys = {
		{ "<leader><Tab>", "<cmd>BufferLineTogglePin<CR>", mode = { "n", "v" } },
		{ "<leader>p", "<cmd>BufferLineCyclePrev<CR>", mode = { "n", "v" } },
		{ "<leader>n", "<cmd>BufferLineCycleNext<CR>", mode = { "n", "v" } },
		{ "<leader><Space>", "<cmd>BufferLinePick<CR>", mode = { "n", "v" } },
		{ "<leader><BS>", "<cmd>bdelete<CR>", mode = { "n", "v" } },
		{ "<leader>mp", "<cmd>BufferLineMovePrev<CR>", mode = { "n", "v" } },
		{ "<leader><mn", "<cmd>BufferLineMoveNext<CR>", mode = { "n", "v" } },
		{ "<leader><S-Tab>", "<cmd>BufferLineCloseOthers<CR>", mode = { "n", "v" } },
		{ "<leader><C-p>", "<cmd>BufferLineCloseLeft<CR>", mode = { "n", "v" } },
		{ "<leader><C-n>", "<cmd>BufferLineCloseRight<CR>", mode = { "n", "v" } },

		{ "<F1>", "<cmd>BufferLineTogglePin<CR>", mode = { "n", "v", "i" } },
		{ "<F2>", "<cmd>BufferLineCyclePrev<CR>", mode = { "n", "v", "i" } },
		{ "<F3>", "<cmd>BufferLineCycleNext<CR>", mode = { "n", "v", "i" } },
		{ "<F13>", "<cmd>bdelete<CR>", mode = { "n", "v", "i" } },
		{ "<F14>", "<cmd>BufferLineMovePrev<CR>", mode = { "n", "v", "i" } },
		{ "<F15>", "<cmd>BufferLineMoveNext<CR>", mode = { "n", "v", "i" } },
		{ "<C-F13>", "<cmd>BufferLineCloseOthers<CR>", mode = { "n", "v", "i" } },
		{ "<C-F14>", "<cmd>BufferLineCloseLeft<CR>", mode = { "n", "v", "i" } },
		{ "<C-F15>", "<cmd>BufferLineCloseRight<CR>", mode = { "n", "v", "i" } },
	},

	-- lazy = false,
}

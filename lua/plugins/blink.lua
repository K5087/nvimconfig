return {
	"saghen/blink.cmp",
	version = "*",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	event = "InsertEnter",
	opts = {
		keymap = {
			preset = "super-tab",
			["<C-u>"] = { "scroll_signature_up", "fallback" },
			["<C-d>"] = { "scroll_signature_down", "fallback" },

			-- default in all keymap presets
			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
		},
		appearance = {
			nerd_font_variant = "mono",
			use_nvim_cmp_as_default = true,
		},
		completion = {
			documentation = { auto_show = false },
		},
		sources = {
			default = { "lsp", "snippets", "path", "buffer" },
		},
		fuzzy = { implementation = "prefer_rust_with_warning", sorts = {
			"score",
			"sort_text",
		} },
		signature = {
			enabled = true,
			trigger = {
				show_on_insert = true,
				show_on_keyword = true,
			},
		},
	},
}

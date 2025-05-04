return {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig"
    },
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    },
    config = function(_, opts)
        require("mason").setup(opts)
        local registry = require("mason-registry")

        local function setup(name, config)
            local success, package = pcall(registry.get_package, name)
            if success and not package:is_installed() then
                package:install()
            end
            local nvim_lsp = require("mason-lspconfig.mappings.server").package_to_lspconfig[name]
            config.capabilities = require("blink.cmp").get_lsp_capabilities()
            require("lspconfig")[nvim_lsp].setup(config)
        end

        local server = {
            ["lua-language-server"] = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }
                        }
                    }
                }
            }
        }
        for name, settings in pairs(server) do
            setup(name, settings)
        end
        vim.cmd("LspStart")
        vim.diagnostic.config({
            virtual_text = true,
            update_in_insert = true,
        })
    end
}

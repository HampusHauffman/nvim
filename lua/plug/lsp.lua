local M = {
    { 'onsails/lspkind.nvim' },
    { 'mfussenegger/nvim-dap' },
    { "fladson/vim-kitty" },
    { "pantharshit00/vim-prisma" },
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup({
                ui = {
                    border = "rounded"
                }
            })
        end
    },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'neovim/nvim-lspconfig' },
    {
        'windwp/nvim-ts-autotag',
        config = function()
            require('nvim-ts-autotag').setup()
        end

    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        config = function()
            -- Make border rounded
            require('lspconfig.ui.windows').default_options.border = 'rounded'
            -- Setup LSP
            local lsp = require('lsp-zero').preset({})
            lsp.extend_lspconfig()
            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
                if client.name == "eslint" then
                    client.server_capabilities.documentFormattingProvider = true
                    client.server_capabilities.documentRangeFormattingProvider = true
                end
            end)
            require('mason-lspconfig').setup({
                handlers = {
                    lsp.default_setup,
                    jdtls = function()
                        -- Disable jdtls so i can set it up manually with nvim-jdtls
                        -- This is Only so we can actually install in with Mason in the firt place
                    end,
                    -- Make sure the tailwindcss server is setup when using https://www.npmjs.com/package/tailwind-styled-components
                    tailwindcss = function()
                        require('lspconfig').tailwindcss.setup({
                            settings = {
                                tailwindCSS = {
                                    experimental = {
                                        classRegex = {
                                            "tw`([^`]*)",
                                            "tw\\.[^`]+`([^`]*)`",
                                            "tw\\(.*?\\).*?`([^`]*)"
                                        }
                                    }
                                }
                            },
                        })
                    end,
                },
            })
        end
    },
}

M[#M + 1] = {
    "folke/neodev.nvim",
    config = function()
        require("neodev").setup({})
    end
}


M[#M + 1] = {
    'simrat39/rust-tools.nvim',
    config = function()
        local rt = require("rust-tools")
        rt.setup({
            server = {
                settings = {
                    ["rust-analyzer"] = {
                        check = {
                            command = "clippy"
                        }
                    }
                },
                on_attach = function(_, bufnr)
                    vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
                end,
            },
        })
        rt.inlay_hints.enable()
    end
}

M[#M + 1] = {
    "akinsho/flutter-tools.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
        require("flutter-tools").setup({
            widget_guides = {
                enabled = true,
            },
            lsp = {
                color = {
                    enabled = true,
                },
            }
        })
    end,
}

M[#M + 1] = {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
        vim.lsp.buf.format { filter = function(client) return client.name ~= "tsserver" end }
        require("typescript-tools").setup {
            settings = {
                --use eslint if it is running
                tsserver_plugins = {
                    -- for TypeScript v4.9+
                    "@styled/typescript-styled-plugin",
                    -- or for older TypeScript versions
                    -- "typescript-styled-plugin",
                },
            },
            on_attach = function(client, bufnr)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,
        }
    end,
    opts = {},
}

M[#M + 1] = {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
        require("trouble").setup({})
    end,
}

M[#M + 1] = {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    -- optionally, override the default options:
    config = function()
        require("tailwindcss-colorizer-cmp").setup({
            color_square_width = 2,
        })
    end
}

M[#M + 1] = {
    'dmmulroy/ts-error-translator.nvim',
}

return M

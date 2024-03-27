local M = {
    { 'onsails/lspkind.nvim' },
    { 'mfussenegger/nvim-dap' },
    { "fladson/vim-kitty" },
    { "pantharshit00/vim-prisma" },
    { "L3MON4D3/LuaSnip" },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    -- LSP Support
    { 'neovim/nvim-lspconfig' },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'hrsh7th/cmp-nvim-lsp',
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lua",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
    },
    {
        'windwp/nvim-ts-autotag',
        config = function()
            require('nvim-ts-autotag').setup()
        end

    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'dev-v3',
        config = function()
            -- Make border rounded
            require('lspconfig.ui.windows').default_options.border = 'rounded'

            -- Setup LSP
            local lsp = require('lsp-zero').preset({})
            lsp.extend_lspconfig()
            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end)

            require('mason').setup({
                ui = {
                    border = "rounded"
                }
            })
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
                            on_attach = function(client, bufnr)
                            end
                        })
                    end,
                },
            })

            require("luasnip.loaders.from_vscode").lazy_load() -- Allow formatting of snippets like vs-code

            -- Setup CMP
            lsp.extend_cmp()
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            cmp.setup({
                completion = {
                    completeopt = 'menu,menuone,noinsert,noselect',
                    autocomplete = {
                        cmp.TriggerEvent.TextChanged,
                        cmp.TriggerEvent.InsertEnter,
                    },

                    keyword_length = 0,
                },
                preselect = 'item',
                autocomplete = true,
                mapping = require("keymaps").cmp,
                window = {
                    completion = cmp.config.window.bordered({
                        winhighlight = "FloatBorder:FloatBorder,Normal:Normal", }),
                    documentation = cmp.config.window.bordered({
                        winhighlight = "FloatBorder:FloatBorder,Normal:Normal", }),
                },
                sources = cmp.config.sources({
                    { name = "copilot" },
                    { name = "nvim_lua" },
                    { name = 'nvim_lsp' },
                    { name = "luasnip" }, -- For luasnip users.
                    { name = 'path' },
                    { name = "crates" },
                }),
                formatting = {
                    fields = { 'kind', 'menu', 'abbr' },
                    format = lspkind.cmp_format({
                        symbol_map = { Copilot = "" },
                        mode = "symbol",
                        maxwidth = 150,
                    }),
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
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            suggestion = { enabled = false, auto_trigger = true, },
            panel = { enabled = false },
        })
    end,
}

M[#M + 1] = {
    "zbirenbaum/copilot-cmp",
    dependencies = {
        "hrsh7th/nvim-cmp",
        "zbirenbaum/copilot.lua",
        "onsails/lspkind.nvim"
    },
    config = function()
        require("copilot_cmp").setup({
            event = { "InsertEnter", "LspAttach" },
            fix_pairs = true,
        })

        -- Make it look nice and work with CMP
        local cmp = require("cmp")

        -- Setup suggested by read me
        cmp.event:on("menu_opened", function()
            vim.b.copilot_suggestion_hidden = true
        end)
        cmp.event:on("menu_closed", function()
            vim.b.copilot_suggestion_hidden = false
        end)
    end,
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

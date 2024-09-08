local M = {
    { 'onsails/lspkind.nvim' },
    { 'mfussenegger/nvim-dap' },
    { "fladson/vim-kitty" },
    { "pantharshit00/vim-prisma" },
}
--write a simple function to clear registers


M[#M + 1] = {
    'neovim/nvim-lspconfig',
    dependencies = { "folke/neodev.nvim" },
    config = function()
        require('lspconfig.ui.windows').default_options.border = 'rounded'
    end
}

M[#M + 1] = {
    'williamboman/mason.nvim',
    config = function()
        require('mason').setup({
            registries = {
                'github:nvim-java/mason-registry',
                'github:mason-org/mason-registry',
            },
            ui = {
                border = "rounded"
            }
        })
    end
}

M[#M + 1] = {
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup {}
                end,
                ["eslint"] = function()
                    require('lspconfig').eslint.setup({
                        on_attach = function(client, bufnr)
                            client.server_capabilities.documentFormattingProvider = true
                            client.server_capabilities.documentRangeFormattingProvider = true
                        end
                    })
                end,
                ["tsserver"] = function()
                    require('lspconfig').tsserver.setup({
                        settings = { typescript = { tsserver = { experimental = { enableProjectDiagnostics = true } } } },
                        on_attach = function(client, bufnr)
                            -- Hacky way to make sure we load the entire workspace into the opened buffers
                            require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
                            client.server_capabilities.documentFormattingProvider = false
                            client.server_capabilities.documentRangeFormattingProvider = false
                        end,
                    })
                end,
--                ["jdtls"] = function()
--                    require('java').setup({})
--                    --require('jdtls').setup({})
--                    require('lspconfig').jdtls.setup({
--                        settings = {
--                            java = {
--                                format = {
--                                    settings = {
--                                        url =
--                                        '/Users/hampushauffman/.config/nvim/lua/jdtls/lang_servers/GoogleStyle.xml',
--                                        profile = 'GoogleStyle',
--                                    }
--                                }
--                            }
--                        }
--                    })
-- Disable jdtls so i can set it up manually with nvim-jdtls
-- This is Only so we can actually install in with Mason in the firt place
--                end,
                ["lua_ls"] = function()
                    require('lspconfig').lua_ls.setup({
                        settings = {
                            Lua = {
                                completion = {
                                    callSnippet = "Replace"
                                }
                            }
                        }
                    })
                end,
                -- Make sure the tailwindcss server is setup when using https://www.npmjs.com/package/tailwind-styled-components
                ["tailwindcss"] = function()
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
            })
        end
    },
}


M[#M + 1] = {
    "folke/neodev.nvim",
    lazy = false,
    config = function()
        require("neodev").setup({
            override = function(root_dir, library)
                library.plugins = true
                library.enabled = true
            end,
            library = {
                plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
            },
            pathStrict = true,

        })
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

-- Silly solve for getting all files analyzed
M[#M + 1] = {
    'artemave/workspace-diagnostics.nvim',
}

--M[#M + 1] = {
--    "pmizio/typescript-tools.nvim",
--    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
--    config = function()
--        --vim.lsp.buf.format { filter = function(client) return client.name ~= "tsserver" end }
--        require("typescript-tools").setup {
--            settings = {
--                --use eslint if it is running
--                tsserver_plugins = {
--                    -- for TypeScript v4.9+
--                    "@styled/typescript-styled-plugin",
--                    -- or for older TypeScript versions
--                    -- "typescript-styled-plugin",
--                },
--            },
--            on_attach = function(client, bufnr)
--                client.server_capabilities.documentFormattingProvider = false
--                client.server_capabilities.documentRangeFormattingProvider = false
--            end,
--        }
--    end,
--    opts = {},
--}

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
    config = function()
        require("ts-error-translator").setup({


        })
    end
}

M[#M + 1] = {
    'nvim-java/nvim-java',
    dependencies = {
        "nvim-java/nvim-java-refactor",
        'nvim-java/lua-async-await',
        'nvim-java/nvim-java-core',
        'nvim-java/nvim-java-test',
        'nvim-java/nvim-java-dap',
        'MunifTanjim/nui.nvim',
        'neovim/nvim-lspconfig',
        'mfussenegger/nvim-dap',
    },
}

return M

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
        -----------------------------------------------------
        -- ColorSchemes
        -----------------------------------------------------
        { "HampusHauffman/dracula.nvim", lazy = false, priority = 1000 },
        { "tiagovla/tokyodark.nvim",     lazy = false, priority = 1000 },
        -----------------------------------------------------
        -- LSP
        -----------------------------------------------------
        "neovim/nvim-lspconfig",
        "jose-elias-alvarez/null-ls.nvim",

        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "jayp0521/mason-null-ls.nvim",

        "pantharshit00/vim-prisma",
        {
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
                        on_attach = function()
                        end,
                    },
                })
                rt.inlay_hints.enable()
            end
        },
        {
            "akinsho/flutter-tools.nvim",
            rquires = "nvim-lua/plenary.nvim",
            config = function()
                require("flutter-tools").setup({}) -- use defaults
            end,
        },
        'mfussenegger/nvim-dap',
        {
            "folke/trouble.nvim",
            dependencies = "kyazdani42/nvim-web-devicons",
            config = function()
                require("trouble").setup({})
            end,
        },
        "fladson/vim-kitty",

        -----------------------------------------------------
        -- CMP
        -----------------------------------------------------
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lua",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",

        -----------------------------------------------------
        -- UI
        -----------------------------------------------------
        {
            "nvim-telescope/telescope.nvim",
            version = "0.1.x",
            dependencies = { "nvim-lua/plenary.nvim" },
        },
        "nvim-telescope/telescope-ui-select.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        { "akinsho/toggleterm.nvim",                  version = "v2.*" },
        {
            "nvim-lualine/lualine.nvim",
            dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
        },
        {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v2.x",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "MunifTanjim/nui.nvim",
                "kyazdani42/nvim-web-devicons",
            }
        },
        "folke/which-key.nvim",
        "nvim-treesitter/nvim-treesitter-context",

        -----------------------------------------------------
        -- Pretty
        -----------------------------------------------------
        {
            "folke/noice.nvim",
            dependencies = {
                "MunifTanjim/nui.nvim",
                --"rcarriga/nvim-notify",
            }
        },
        "nvim-treesitter/nvim-treesitter", -- Syntax highligting
        "onsails/lspkind.nvim",            -- Symbols / icons
        "p00f/nvim-ts-rainbow",            -- Rainbow colored brackets
        "RRethy/vim-illuminate",           -- Highlight words that match cursos
        "folke/zen-mode.nvim",             -- Zen mode
        {
            "luukvbaal/stabilize.nvim",
            config = function()
                require("stabilize").setup()
            end,
        },
        {
            "j-hui/fidget.nvim",
            config = function()
                require("fidget").setup({})
            end,
        },
        {
            "folke/todo-comments.nvim",
            dependencies = "nvim-lua/plenary.nvim",
            config = function()
                require("todo-comments").setup {
                }
            end
        },

        -----------------------------------------------------
        -- Movement
        -----------------------------------------------------
        {
            "ggandor/leap.nvim",
            lazy = false,
            dependencies = { "tpope/vim-repeat", lazy = true },
            config = function()
                require("leap").add_default_mappings()
            end,
        },

        -----------------------------------------------------
        -- Util
        -----------------------------------------------------
        "folke/neodev.nvim",
        {
            'lewis6991/gitsigns.nvim',
            config = function()
                require('gitsigns').setup()
            end
        },
        "christoomey/vim-tmux-navigator",
        "tpope/vim-sleuth",
        {
            "Pocco81/auto-save.nvim",
            config = function()
                require("auto-save").setup {
                    -- your config goes here
                    -- or just leave it empty :)
                }
            end,
        },
        {
            "nvim-treesitter/playground",
            config = function()
                require("nvim-treesitter.configs").setup({
                    playground = {
                        enable = true,
                        disable = {},
                        updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
                        persist_queries = false, -- Whether the query persists across vim sessions
                        keybindings = {
                            toggle_query_editor = "o",
                            toggle_hl_groups = "i",
                            toggle_injected_languages = "t",
                            toggle_anonymous_nodes = "a",
                            toggle_language_display = "I",
                            focus_language = "f",
                            unfocus_language = "F",
                            update = "R",
                            goto_node = "<cr>",
                            show_help = "?",
                        },
                    },
                })
            end,
        },
        {
            "windwp/nvim-autopairs",
            config = function()
                require("nvim-autopairs").setup({})
                local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                local cmp = require("cmp")
                cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
            end,
        },
    },
    {
        defaults = {
            lazy = false, -- should plugins be lazy-loaded?
        },
    }
)

require "options"
require "keymaps"
require "autocmd"
require "color"

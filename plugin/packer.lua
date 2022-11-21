-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

vim.cmd [[packadd packer.nvim]]

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    vim.o.runtimepath = vim.fn.stdpath "data" .. "/site/pack/*/start/*," .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end


-- Install plugins
return packer.startup(function(use)
    -- Add you plugins here:
    use { "wbthomason/packer.nvim" }

    -- Theme
    use { "HampusHauffman/dracula.nvim" }
    use { "tiagovla/tokyodark.nvim" }

    -- Dev Icons
    use { "kyazdani42/nvim-web-devicons" }

    -- NeoTree
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "kyazdani42/nvim-web-devicons",
        },
    }

    use {
        "lewis6991/gitsigns.nvim",
        tag = "release", -- To use the latest release
        config = function()
            require("gitsigns").setup()
        end
    }
    -- Scrollbar
    --use { "petertriho/nvim-scrollbar", config = function()
    --    require("scrollbar").setup({
    --           marks = {
    --               excluded_buftypes = {
    --                   "terminal",
    --                   "neo-tree*"
    --               },
    --               excluded_filetypes = {
    --                   "prompt",
    --                   "TelescopePrompt",
    --                   "noice",
    --                   "neo-tree*",
    --               },
    --           }
    --       })
    --   end }

    -- Sets shiftwidth (no setup)
    use { "tpope/vim-sleuth" }
    -- Syntax highlighting
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    -- Show current context as top line
    use { "nvim-treesitter/nvim-treesitter-context" }
    -- Rainbow parenthesis
    use { "p00f/nvim-ts-rainbow", config = function()
    end }
    -- Show nvim values
    use { "nvim-treesitter/playground", config = function()
        require "nvim-treesitter.configs".setup {
            playground = {
                enable = true,
                disable = {},
                updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
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
            }
        }
    end }

    -- Autocomplete
    use { "hrsh7th/nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lsp" }
    use { "hrsh7th/cmp-buffer" }
    use { "hrsh7th/cmp-path" }
    use { "hrsh7th/cmp-cmdline" }
    use { "hrsh7th/cmp-nvim-lua" }
    -- Fancy symbols for cmp
    use { "onsails/lspkind.nvim" }

    -- LSP
    use { "neovim/nvim-lspconfig" }

    -- Language provider installer
    use { "williamboman/mason.nvim" }
    use { "williamboman/mason-lspconfig.nvim" }

    -- Non LSP linting
    use { "jose-elias-alvarez/null-ls.nvim",
        rquires = "nvim-lua/plenary.nvim", }

    -- Order matters Mason null-ls this!
    use { "jayp0521/mason-null-ls.nvim", config = function()
        require("mason").setup()
        require("mason-null-ls").setup({
            automatic_setup = true,
        })
        require "mason-null-ls".setup_handlers {
            function(source_name, methods)
                -- all sources with no handler get passed here
                -- Keep original functionality of `automatic_setup = true`
                require "mason-null-ls.automatic_setup" (source_name, methods)
            end,
        }
        require("null-ls").setup()
    end }


    -- LSP Loading icon
    use { "j-hui/fidget.nvim", config = function()
        require "fidget".setup {}
    end
    }

    -- LSP Flutter
    use {
        "akinsho/flutter-tools.nvim",
        rquires = "nvim-lua/plenary.nvim",
        config = function()
            require("flutter-tools").setup({}) -- use defaults
        end
    }

    -- LSP Prisma
    use { "pantharshit00/vim-prisma" }

    -- Snippets source for nvim-cmp
    use { "L3MON4D3/LuaSnip" }
    use { "saadparwaiz1/cmp_luasnip" }
    use { "rafamadriz/friendly-snippets", config = function()
        require "luasnip".filetype_extend("ruby", { "rails" })
        require "luasnip".filetype_extend("dart", { "flutter" })
    end }

    -- Automatic character pairs
    use {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {}
            local cmp_autopairs = require "nvim-autopairs.completion.cmp"
            local cmp = require "cmp"
            cmp.event:on(
                "confirm_done",
                cmp_autopairs.on_confirm_done()
            )
        end
    }

    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {}
        end
    }

    -- Telescope (fuzz)
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

    use { "nvim-telescope/telescope-ui-select.nvim" }

    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.x",
        requires = { "nvim-lua/plenary.nvim", }
    }


    -- Smooth Scrolling use {
    use {
        "declancm/cinnamon.nvim",
        config = function()
            require("cinnamon").setup {
                extra_keymaps = true,
                override_keymaps = true,
                max_length = 500,
                scroll_limit = 100,
            }
        end
    }


    -- Blank line
    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,
                use_treesitter = true,
                use_treesitter_scope = true,
                char = "▎",
            }
        end
    }

    -- Terminal
    use { "akinsho/toggleterm.nvim", tag = "v2.*" }

    -- Line
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    }

    -- Stabalize splits so they dont jump around
    use { "luukvbaal/stabilize.nvim",
        config = function()
            require("stabilize").setup()
        end
    }

    -- Which key
    use({ "folke/which-key.nvim" })

    -- Highlight words that match cursos
    use { "RRethy/vim-illuminate" }

    -- Better quickfix
    use { "kevinhwang91/nvim-bqf", ft = "qf" }

    use { "folke/zen-mode.nvim", config = function()
        require("zen-mode").setup {
            window = {
                backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
                height = 0.90, -- height of the Zen window
                options = {
                    signcolumn = "no", -- disable signcolumn
                },
                kitty = {
                    enabled = false,
                    font = "+4", -- font size increment
                },
                gitsigns = { enabled = false }, -- disables git signs
            }
        }
    end }

    -- Start screen

    -- Sticks the buffesrs (Might show up in NVIM eventually)
    use { "stevearc/stickybuf.nvim", config = function()
        require("stickybuf").setup({
            filetype = {
                ["neo-tree"] = "filetype",
                ["toggleterm"] = "filetype",
                ["aerial"] = "filetype",
            }

        })
    end }

    -- Symbol list
    use {
        "stevearc/aerial.nvim",
        config = function()
            require("aerial").setup()
            require("lspconfig").vimls.setup {
                on_attach = require("aerial").on_attach,
            }
        end
    }

    use { "edluffy/specs.nvim", }

    use { "ggandor/leap.nvim",
        requires = { "tpope/vim-repeat", opt = true },
        config = function()
            require("leap").add_default_mappings()
        end }

    -- Tmux (no setup)
    use { "christoomey/vim-tmux-navigator" }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)

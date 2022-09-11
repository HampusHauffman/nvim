-----------------------------------------------------------
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
    use "wbthomason/packer.nvim"

    -- Theme
    use({ "Mofiqul/dracula.nvim" })

    -- Dev Icons
    use({ "kyazdani42/nvim-web-devicons" })

    -- NeoTree
    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
    })

    -- Git side status
    use {
        "lewis6991/gitsigns.nvim",
        tag = "release", -- To use the latest release
        config = function()
            require("gitsigns").setup()
        end
    }

    -- Syntax highlighting
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use "nvim-treesitter/nvim-treesitter-context"

    -- Autocomplete
    use({ "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-buffer" })
    use({ "hrsh7th/cmp-path" })
    use({ "hrsh7th/cmp-cmdline" })
    use({ "hrsh7th/cmp-nvim-lua" })

    -- LSP
    use({ "neovim/nvim-lspconfig" })
    use({ "williamboman/mason.nvim" })
    use({ "williamboman/mason-lspconfig.nvim" })

    -- LSP Loading icon
    use { "j-hui/fidget.nvim", config = function()
        require "fidget".setup {}
    end }

    -- LSP Flutter
    use({
        "akinsho/flutter-tools.nvim",
        rquires = "nvim-lua/plenary.nvim",
        config = function()
            require("flutter-tools").setup({}) -- use defaults
        end,
    })

    -- LSP Prisma
    use({ "pantharshit00/vim-prisma" })

    -- Snippets source for nvim-cmp
    use({ "L3MON4D3/LuaSnip" })
    use({ "saadparwaiz1/cmp_luasnip" })
    use({ "rafamadriz/friendly-snippets" })

    -- Automatic character pairs
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {}
        end
    }

    -- Telescope (fuzz)
    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.x",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

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
    use { "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {}
        end }

    -- Terminal
    use { "akinsho/toggleterm.nvim", tag = "v2.*" }

    -- Line
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "dracula-nvim"
                }
            })
        end
    }

    -- Stabalize splits so they dont jump around
    use {
        "luukvbaal/stabilize.nvim",
        config = function() require("stabilize").setup() end
    }

    -- Which key
    use({ "folke/which-key.nvim" })

    -- Splits
    use { "beauwilliams/focus.nvim", config = function() require("focus").setup({
            excluded_filetypes = { "fterm", "term", "toggleterm" }
        })
    end }

    use { "RRethy/vim-illuminate" }


    use {'kevinhwang91/nvim-bqf', ft = 'qf'}


    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)

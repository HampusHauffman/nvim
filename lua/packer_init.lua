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
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
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
    use "wbthomason/packer.nvim" -- packer can manage itself

    -- Theme
    use({ "dracula/vim", as = "dracula" })

    -- Dev Icons
    use({ "kyazdani42/nvim-web-devicons" })

    -- Tree
    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
    })

    -- Syntax highlighting
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

    -- Autocomplete
    use({ "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-buffer" })
    use({ "hrsh7th/cmp-path" })
    use({ "hrsh7th/cmp-cmdline" })
    use({ "hrsh7th/cmp-nvim-lua" })

    -- Package manager for LSP
    use({
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
    })

    -- LSP Loading icon
    use { "j-hui/fidget.nvim", config = function()
        require "fidget".setup {}
    end }

    -- LSP Flutter
    use({
        "akinsho/flutter-tools.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("flutter-tools").setup({}) -- use defaults
        end,
    })

    -- Snippets source for nvim-cmp
    use({ "/L3MON4D3/LuaSnip" })
    use({ "saadparwaiz1/cmp_luasnip" })
    use({ "rafamadriz/friendly-snippets" })

    -- Linting
    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("null-ls").setup()
        end,
        requires = { "nvim-lua/plenary.nvim" },
    })


    -- Telescope (fuzz)
    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.0",
        -- or                            , branch = '0.1.x',
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

    -- Smooth Scrolling
    use {
        "declancm/cinnamon.nvim",
        config = function()
            require("cinnamon").setup {
                extra_keymaps = true,
                override_keymaps = true,
                max_length = 500,
                scroll_limit = -1,
            }
        end
    }

    -- Git integration
    use {
        "lewis6991/gitsigns.nvim",
        tag = "release", -- To use the latest releasu
    }

    -- Blank line
    use { "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {
            }
        end }

    -- Terminal
    use { "akinsho/toggleterm.nvim", tag = "v2.*", config = function()
        require("toggleterm").setup()
    end }

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

    -- Which key
    use({ "folke/which-key.nvim" })
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)

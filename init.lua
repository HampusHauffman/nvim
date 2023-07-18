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

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
		{ import = "plug" },
		{
			"HampusHauffman/block.nvim",
			dev = true,
			--branch = "scroll",
			config = function()
				require("block").setup({
					percent = 0.93,
					depth = 4,
					automatic = true
				})
			end
		},
		"HampusHauffman/bionic.nvim",
		-----------------------------------------------------
		-- ColorSchemes
		-----------------------------------------------------
		{ "HampusHauffman/dracula.nvim", lazy = false, priority = 1000 },
		{ "tiagovla/tokyodark.nvim",     lazy = false, priority = 1000 },
		-----------------------------------------------------
		-- UI
		-----------------------------------------------------
		{
			"karb94/neoscroll.nvim",
			config = function()
				require('neoscroll').setup()
			end
		},
		--"nvim-treesitter/nvim-treesitter-context",

		-----------------------------------------------------
		-- Pretty
		-----------------------------------------------------
		'stevearc/dressing.nvim',
		--"p00f/nvim-ts-rainbow",            -- Rainbow colored brackets
		"RRethy/vim-illuminate", -- Highlight words that match cursos
		{
			"luukvbaal/stabilize.nvim",
			config = function()
				require("stabilize").setup({
				})
			end,
		},
		{
			"folke/todo-comments.nvim",
			dependencies = "nvim-lua/plenary.nvim",
			config = function()
				require("todo-comments").setup {}
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
		"christoomey/vim-tmux-navigator",

		-----------------------------------------------------
		-- Util
		-----------------------------------------------------
		{
			'lewis6991/gitsigns.nvim',
			config = function()
				require('gitsigns').setup()
			end
		},
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
		dev = {
			path = "~/Documents",
			fallback = false, -- Fallback to git when local plugin doesn't exist
		},
		install = {
			colorscheme = { "dracula" },
		},
		ui = {
			border = "rounded",

		}
	}
)

require "options"
require "keymaps"
require "autocmd"
require "color"

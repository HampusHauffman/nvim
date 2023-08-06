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
		-----------------------------------------------------
		-- My plugins
		-----------------------------------------------------
		{
			"HampusHauffman/peacock.nvim",
			dev = true,
			config = function(_, _)
				require("peacock")
			end
		},
--		{
--			"HampusHauffman/block.nvim",
--			dev = true,
--			branch = "main",
--			config = function()
--				require("block").setup({
--					percent = 1.2,
--					depth = 4,
--					automatic = true
--				})
--			end
--		},
		"HampusHauffman/bionic.nvim",
		-----------------------------------------------------
		-- GPT
		-----------------------------------------------------
		{
			"jackMort/ChatGPT.nvim",
			event = "VeryLazy",
			config = function()
				require("chatgpt").setup({
					api_key = "echo $CHATGPT_API_KEY",
				})
			end,
			dependencies = {
				"MunifTanjim/nui.nvim",
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim"
			}
		},
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
		{
			"NvChad/nvim-colorizer.lua",
			config = function()
				require 'colorizer'.setup({})
			end
		},
		"stevearc/dressing.nvim",
		--"p00f/nvim-ts-rainbow",            -- Rainbow colored brackets
		"RRethy/vim-illuminate", -- Highlight words that match cursos
		--{
		--	"luukvbaal/stabilize.nvim",
		--	config = function()
		--		require("stabilize").setup({
		--		})
		--	end,
		--},
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
			"chrisgrieser/nvim-spider",
			lazy = true,
			config = function()
				require("spider").setup({
					skipInsignificantPunctuation = true
				})
				vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>",
					{ desc = "Spider-w" })
				vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>",
					{ desc = "Spider-e" })
				vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>",
					{ desc = "Spider-b" })
				vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>",
					{ desc = "Spider-ge" })
			end
		},
		{
			"max397574/better-escape.nvim",
			config = function()
				require("better_escape").setup {
					mapping = { "jk", "kj" }, -- a table with mappings to use
					timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
					clear_empty_lines = false, -- clear line after escaping if there is only whitespace
					keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
				}
			end
		},
		{
			"folke/flash.nvim",
			--event = "VeryLazy",
			opts = {},
			keys = {}
		},
		"christoomey/vim-tmux-navigator",

		-----------------------------------------------------
		-- Util
		-----------------------------------------------------
		"tpope/vim-sleuth",
		{
			'lewis6991/gitsigns.nvim',
			config = function()
				require('gitsigns').setup()
			end
		},
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
			dependencies = {
				"hrsh7th/nvim-cmp",
			},
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

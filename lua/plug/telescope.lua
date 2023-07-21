local M = {
	{ "nvim-telescope/telescope-ui-select.nvim", },
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
}

M[#M + 1] = {
	"nvim-telescope/telescope.nvim",
	version = "0.1.x",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup {
			defaults = {
				winblend = 0,
				mappings = {
					n = {
						["kj"] = "close",
						["jk"] = "close",
					},
					i = {
						["<S-Tab>"] = "move_selection_previous",
						["<Tab>"] = "move_selection_next",
						["<C-k>"] = "move_selection_previous",
						["<C-j>"] = "move_selection_next",
					},
				},
				prompt_prefix = " ",
				selection_caret = " ",
				--layout_strategy = "flex",
				layout_strategy = "vertical",
				sorting_strategy = "ascending",
				mirror = false,
				layout_config = {
					horizontal = {
						prompt_position = "top",
						width = 0.8,
						preview_width = 0.666666,
					},
					vertical = {
						height = 0.9,
						preview_cutoff = 40,
						prompt_position = "bottom",
						width = 0.8
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,    -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				},
				["ui-select"] = {
					require("telescope.themes").get_cursor {}
				}
			},
		}
		require("telescope").load_extension "fzf"
		require("telescope").load_extension "ui-select"
		require("telescope").load_extension "flutter"
		require("telescope").load_extension "noice"
	end
}

return M

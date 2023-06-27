local keymaps = require "keymaps".telescope
require("telescope").setup {
    defaults = {
        winblend = 0,
        mappings = keymaps,
        prompt_prefix = " ",
        selection_caret = " ",
        layout_strategy = "flex",
        sorting_strategy = "ascending",
        mirror = false,
        layout_config = {
            horizontal = {
                prompt_position = "top",
                width = 0.8,
                preview_width = 0.666666,
            }
            -- other layout configuration here
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
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

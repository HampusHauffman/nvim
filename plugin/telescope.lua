local keymaps = require "keymaps".telescope
require("telescope").setup {
    defaults = {
        winblend = 0,
        mappings = keymaps,
        prompt_prefix = " ",
        selection_caret = " ",
        layout_strategy = "horizontal",
        sorting_strategy = "ascending",
        mirror = false,
        layout_config = {
            horizontal = {
                prompt_position = "top",
                width = 0.7,
                preview_width = 0.6,
            }
            -- other layout configuration here
        },
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_cursor {}
        }
    },
}
require("telescope").load_extension "fzf"
require("telescope").load_extension "ui-select"
require("telescope").load_extension "flutter"
require("telescope").load_extension("noice")

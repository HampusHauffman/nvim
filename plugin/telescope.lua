local keymaps = require "keymaps".telescope
require("telescope").setup {
    defaults = {
        mappings = keymaps,
    }
}
require("telescope").load_extension "fzf"
--require("telescope").load_extension "flutter"

require("telescope").load_extension "fzf"
local keymaps = require "keymaps".telescope
require("telescope").setup{
    defaults = keymaps
}
--require("telescope").load_extension "flutter"

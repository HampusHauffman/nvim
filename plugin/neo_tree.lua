-- Defaults:
-- https://github.com/nvim-neo-tree/neo-tree.nvim/blob/v2.x/lua/neo-tree/defaults.lua
-- Disable Neotree legacy commands
vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]
require("neo-tree").setup({
    filesystem = {
        filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,

        }
    },
    default_component_configs = {
    }
})

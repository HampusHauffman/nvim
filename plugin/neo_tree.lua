-- https://github.com/nvim-neo-tree/neo-tree.nvim/blob/v2.x/lua/neo-tree/defaults.lua
-- Disable Neotree legacy commands
vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]
require("neo-tree").setup({
    popup_border_style = "rounded",
    sources = {
        "filesystem",
        "git_status",
    },
    source_selector = {
        winbar = true,
        statusline = false
    },
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    enable_git_status = true,
    enable_modified_markers = true, -- Show markers for files with unsaved changes.
    enable_refresh_on_write = true, -- Refresh the tree when a file is written. Only used if `use_libuv_file_watcher` is false.
    git_status_async = true,
    sort_case_insensitive = true, -- used when sorting files and directories in the tree
    default_component_configs = {
        container = {
            enable_character_fade = true,
            width = "100%",
            right_padding = 0,
        },
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "ﰊ",
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon"
        },
        modified = {
            symbol = "✚ ",
            highlight = "NeoTreeModified",
        },
        git_status = {
            symbols = {
                -- Change type
                added    = "✚",
                deleted  = "",
                modified = "",
                renamed  = "",
            },
        },
    },
    window = {
        width = 30, -- applies to left and right positions
    }, filesystem = {
        follow_current_file = true,
        use_libuv_file_watcher = true,
        filtered_items = {
            visible = true, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
            hide_gitignored = false,
        },
    }
})

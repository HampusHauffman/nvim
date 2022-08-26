require("toggleterm").setup({
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    terminal_mappings = true,
    persist_size = true,
    shade_terminals = false,
    direction = 'vertical',
    highlights = {
        Normal = {
            guibg = require "dracula".colors().menu,
        },
    }
})

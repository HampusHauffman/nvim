require("toggleterm").setup({
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    terminal_mappings = true,
    persist_size = true,
    shade_terminals = false,
    height = 10,
    direction = "horizontal",
    highlights = {
        Normal = {
            guibg = require "dracula".colors().menu,
        },
    }
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit  = Terminal:new({ cmd = "lazygit",
    hidden = true,
    direction = "float"
})

function _lazygit_toggle()
    lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

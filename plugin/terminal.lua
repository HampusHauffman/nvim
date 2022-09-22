require("toggleterm").setup({
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    terminal_mappings = true,
    persist_size = true,
    shade_terminals = false,
    height = 10,
    direction = "horizontal",
    float_opts = {
        border = "curved",
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
    highlights = {
        Normal = {
            link = "Menu"
        },
        NormalFloat = {
            link = "Menu"
        },
        FloatBorder = {
            link = "Border"
        }
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

local M = {}
M[#M + 1] = {
    "folke/which-key.nvim",
    config = function()
        require("which-key").setup {
            window = {
                border = "rounded",         -- none, single, double, shadow
                position = "bottom",        -- bottom, top
                margin = { 15, 15, 5, 15 }, -- extra window margin [top, right, bottom, left]
            },
            layout = {
                height = { min = 4, max = 25 }, -- min and max height of the columns
                width = { min = 20, max = 50 }, -- min and max width of the columns
                spacing = 3,                    -- spacing between columns
                align = "center",               -- align columns left, center or right
            },
            triggers = "auto",                  -- automatically setup triggers
            -- triggers = { "<leader>" } -- or specify a list manually
        }

        local wk = require "which-key"

        wk.register({
            ["<CR>"] = "which_key_ignore", -- special label to hide it in the popup
        }, { prefix = "<leader>" })
    end
}
return M

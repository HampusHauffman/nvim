require("lualine").setup({
    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
--    winbar = {
--        lualine_a = { "mode" },
--        lualine_b = { "branch", "diff", "diagnostics" },
--        lualine_c = { { "filename" } },
--        lualine_x = { "encoding", "fileformat", "filetype" },
--        lualine_y = { "progress" },
--        lualine_z = { "location" }
--    },
--    inactive_winbar = {
--        lualine_a = { "mode" },
--        lualine_b = { "branch", "diff", "diagnostics" },
--        lualine_c = { "filename" },
--        lualine_x = { "encoding", "fileformat", "filetype" },
--        lualine_y = { "progress" },
--        lualine_z = { "location" },
--    },
    options = {
globalstatus = true,
        disabled_filetypes = {
            winbar = { "neo-tree", "terminal", "toggleterm" },
        },

    }
})

-- Disable statusline, Set to 2 for default
vim.opt.ls = 0



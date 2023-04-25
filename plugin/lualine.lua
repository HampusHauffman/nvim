require("lualine").setup({
    options = {
        theme = 'dracula-nvim',
        extensions = { 'quickfix' },
        component_separators = '  ',
        section_separators = { left = '', right = '' },
        globalstatus = true,
        disabled_filetypes = {
            winbar = { "neo-tree", "terminal", "toggleterm" },
        },
    },
    sections = {
        lualine_a = {
            { 'mode', separator = { left = '  ' }, right_padding = 2 },
        },
        lualine_b = { { 'filename', icon = { '', align = 'left' } }, 'branch' },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { 'filetype', 'progress' },
        lualine_z = {
            { 'location', separator = { right = '  ' }, left_padding = 2 },
        },
    },
    --        lualine_a = { "mode" },
    --        lualine_b = { "branch", "diff", "diagnostics" },
    --        lualine_c = { "filename" },
    --        lualine_x = { "encoding", "fileformat", "filetype" },
    --        lualine_y = { "progress" },
    --        lualine_z = { "location" },
    --    },
})

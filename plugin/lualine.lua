local tmux_tabs = ""

local function get_tmux_tabs()
    if tmux_tabs == "" then
        tmux_tabs = vim.fn.system([[tmux list-windows -F "#{window_index}:#{window_name}" | tr '\n' ' ']])
        tmux_tabs = tmux_tabs:gsub("%s+$", "") -- Remove trailing whitespace
    end
    return tmux_tabs
end

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
        lualine_c = { get_tmux_tabs },
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

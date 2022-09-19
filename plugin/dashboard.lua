local M = {}
local home = os.getenv "HOME"
local db = require "dashboard"
local colors = require "dracula".colors()

db.custom_header = {

    "███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
    "  ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
    "   ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
    "     ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
    "       ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
    "       ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝"
}



db.preview_file_height = 11
db.preview_file_width = 70
db.header_pad = 5
db.center_pad = 2
db.custom_center = {
    { icon = "  ",
        icon_hl = { fg = colors.green },
        desc = "Recently opened files                   ",
        action = "lua require('telescope.builtin').oldfiles()",
        shortcut = "SPC e" },
    { icon = "  ",
        icon_hl = { fg = colors.purple },
        desc = "Find  File                              ",
        action = "Telescope find_files find_command=rg,--hidden,--files",
        shortcut = "f f  " },
    { icon = "  ",
        icon_hl = { fg = colors.cyan },
        desc = "Find  word                              ",
        action = "Telescope live_grep",
        shortcut = "f g  " },
    { icon = "  ",
        icon_hl = { fg = colors.pink },
        desc = "Open Nvim config                        ",
        action = "e " .. home .. "/.config/nvim",
        shortcut = "     " },
}
return M

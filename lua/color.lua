-----------------------------------------------------------
-- Color
-----------------------------------------------------------
vim.cmd [[colorscheme dracula]]

local colors = require "dracula".colors()

local hl = function(group, fg, bg)
    fg = fg and "guifg=" .. fg or "guifg=NONE"
    bg = bg and "guibg=" .. bg or "guibg=NONE"
    vim.api.nvim_command("highlight " .. group .. " " .. fg .. " " .. bg)
end

-- NeoTree
hl("NeoTreeNormal", colors.fg, colors.menu)
hl("NeoTreeNormalNC", colors.fg, colors.menu)
--hl("NeoTreeFloatBorder", colors.menu, colors.menu)
hl("NeoTreeFloatTitle", colors.cyan, colors.menu)

hl("MsgArea", colors.cyan, colors.menu)
hl("Menu", colors.cyan, colors.menu)
hl("CursorLineNr", colors.cyan, nil)

hl("VertSplit", colors.menu, colors.menu)

-- IndentLines
hl("IndentBlanklineIndent1", colors.bright_red, colors.bright_red)
hl("IndentBlanklineIndent2", colors.bright_yellow, colors.bright_yellow)
hl("IndentBlanklineIndent3", colors.bright_green, colors.bright_green)
hl("IndentBlanklineIndent4", colors.bright_blue, colors.bright_blue)
hl("IndentBlanklineIndent5", colors.bright_magenta, colors.bright_magenta)
hl("IndentBlanklineIndent5", colors.bright_cyan, colors.bright_cyan)

-- TreeSitter
hl("TSProperty", colors.orange, nil)
hl("TSVariable", colors.purple, nil)

-- Dashboard
hl("DashboardCenter", colors.cyan, nil)
hl("DashboardHeader", colors.green, nil)
hl("DashboardShortCut", colors.pink, nil)
hl("DashboardFooter", colors.purple, nil)

-- CMP
hl("CmpItemAbbr", colors.cyan, nil)
hl("CmpItemAbbrMatch", colors.green, nil)

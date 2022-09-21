-----------------------------------------------------------
-- Color
-----------------------------------------------------------
vim.cmd [[colorscheme dracula]]

local colors = require "dracula".colors()

local highlight = function(group, fg, bg)
    fg = fg and "guifg=" .. fg or "guifg=NONE"
    bg = bg and "guibg=" .. bg or "guibg=NONE"
    vim.api.nvim_command("highlight " .. group .. " " .. fg .. " " .. bg)
end

-- NeoTree
highlight("NeoTreeNormal", colors.fg, colors.menu)
highlight("NeoTreeNormalNC", colors.fg, colors.menu)
highlight("NeoTreeFloatBorder", colors.menu, colors.menu)
highlight("NeoTreeFloatTitle", colors.cyan, colors.menu)
highlight("NeoTreeTitleBar", colors.fg, colors.menu)

highlight("MsgArea", colors.cyan, colors.menu)
highlight("Menu", colors.cyan, colors.menu)
highlight("CursorLineNr", colors.cyan, nil)

highlight("VertSplit", colors.menu, colors.menu)

-- IndentLines
highlight("IndentBlanklineIndent1", colors.bright_red, colors.bright_red)
highlight("IndentBlanklineIndent2", colors.bright_yellow, colors.bright_yellow)
highlight("IndentBlanklineIndent3", colors.bright_green, colors.bright_green)
highlight("IndentBlanklineIndent4", colors.bright_blue, colors.bright_blue)
highlight("IndentBlanklineIndent5", colors.bright_magenta, colors.bright_magenta)
highlight("IndentBlanklineIndent5", colors.bright_cyan, colors.bright_cyan)


-- Dashboard
highlight("DashboardCenter", colors.cyan, nil)
highlight("DashboardHeader", colors.green, nil)
highlight("DashboardShortCut", colors.pink, nil)
highlight("DashboardFooter", colors.purple, nil)

-- CMP
highlight("CmpItemAbbr", colors.cyan, nil)
highlight("CmpItemAbbrMatch", colors.green, nil)

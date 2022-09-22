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

local link = function(group, target)
    vim.api.nvim_command("hi! link " .. group .. " " .. target)
end

hl("Border", colors.menu, colors.menu)
hl("Menu", colors.fg, colors.menu)

-- Terminal
link("Terminal", "Menu")

-- NeoTree
link("NeoTreeNormal", "Menu")
link("NeoTreeNormalNC", "Menu")
link("NeoTreeFloatBorder", "Border")
--hl("NeoTreeFloatBorder", colors.menu, colors.menu)
hl("NeoTreeFloatTitle", colors.cyan, colors.menu)

link("MsgArea", "Menu")
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

hl("TelescopePromptNormal", colors.fg, colors.bg)
hl("TelescopePromptBorder", colors.bg, colors.bg)
hl("TelescopePromptTitle", colors.fg, colors.bg)
link("TelescopePreviewTitle","Menu")
link("TelescopeResultsTitle","Menu")
link("TelescopeNormal","Menu")
link("TelescopeBorder", "Border")
link("TelescopeResultsBorder", "Border")
link("TelescopePreviewBorder", "Border")

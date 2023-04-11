-----------------------------------------------------------
-- Color
-----------------------------------------------------------
vim.cmd [[colorscheme dracula]]


local hl = function(group, fg, bg)
    fg = fg and "guifg=" .. fg or "guifg=NONE"
    bg = bg and "guibg=" .. bg or "guibg=NONE"
    vim.api.nvim_command("highlight" .. group .. " " .. fg .. " " .. bg)
end

local link = function(group, target)
    vim.api.nvim_command("hi! link " .. group .. " " .. target)
end

-- Menu
link("Pmenu", "Normal")
link("CmpItemAbbrMatch", "@text.strong")
--link("", "@text.strong")

-- Terminal
link("Terminal", "Pmenu")

-- Border
link("FloatBorder", "TelescopePromptBorder")
link("TelescopeBorder", "TelescopePromptBorder")

link("NeoTreeTabActive", "Normal")
link("NeoTreeTabSeparatorActive", "Normal")
link("NeoTreeTabInactive", "Pmenu")
link("NeoTreeTabSeparatorInactive", "Pmenu")

-- IndentLines
link("IndentBlankLineContextChar", "Underline")
--hl("IndentBlanklineIndent1", colors.purple, colors.purple)
--hl("IndentBlanklineIndent2", colors.bright_yellow, colors.bright_yellow)
--hl("IndentBlanklineIndent3", colors.bright_green, colors.bright_green)
--hl("IndentBlanklineIndent4", colors.bright_blue, colors.bright_blue)
--hl("IndentBlanklineIndent5", colors.bright_magenta, colors.bright_magenta)
--hl("IndentBlanklineIndent5", colors.bright_cyan, colors.bright_cyan)

-- TreeSitter
link("@property", "@parameter")
link("@variable", "@constant")

-- Rainbow TreeSitter
link("rainbowcol1", "@boolean")


vim.fn.sign_define("DiagnosticSignError",
    { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn",
    { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo",
    { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint",
    { text = "", texthl = "DiagnosticSignHint" })

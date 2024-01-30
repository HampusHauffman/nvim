-----------------------------------------------------------
-- Color
-----------------------------------------------------------
vim.cmd("colorscheme dracula")

local function italic(grp)
	vim.api.nvim_command("highlight " .. grp .. " gui=italic")
end

local function bold(grp)
	vim.api.nvim_command("highlight " .. grp .. " gui=bold")
end

local hl = function(group, fg, bg)
	fg = fg and "guifg=" .. fg or "guifg=NONE"
	bg = bg and "guibg=" .. bg or "guibg=NONE"
	vim.api.nvim_command("highlight " .. group .. " " .. fg .. " " .. bg)
end

local link = function(group, target)
	vim.api.nvim_command("hi! link " .. group .. " " .. target)
end

-- Menu
link("Pmenu", "Normal")
link("CmpItemAbbrMatch", "@text.strong")

-- Border
link("FloatBorder", "TelescopePromptBorder")
link("TelescopeBorder", "FloatBorder")
link("WinSeparator", "FloatBorder")
link("NeoTreeFloatBorder", "FloatBorder")

-- StatusLine
link("StatusLine", "Normal")

link("NeoTreeTabActive", "Normal")
link("NeoTreeTabSeparatorActive", "Normal")
link("NeoTreeTabInactive", "Pmenu")
link("NeoTreeTabSeparatorInactive", "Pmenu")

-- IndentLines
link("IndentBlankLineContextChar", "Underline")

italic("Comment")
bold("@variable")
-- TreeSitter
link("@lsp.type.property", "@field")
link("@variable", "@constant")
link("@lsp.type.variable", "@variable")
-- Rainbow TreeSitter (fixes ugly red first color)
link("rainbowcol1", "@boolean")


vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

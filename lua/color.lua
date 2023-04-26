-----------------------------------------------------------
-- Color
-----------------------------------------------------------
vim.cmd("colorscheme dracula")

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

-- TreeSitter
link("@property", "@parameter")
link("@variable", "@variable.builtin")
link("@lsp.type.variable", "@variable")
vim.api.nvim_command("highlight Comment cterm=bold")
-- Rainbow TreeSitter (fixes ugly red first color)
link("rainbowcol1", "@boolean")


vim.fn.sign_define("DiagnosticSignError",
	{ text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn",
	{ text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo",
	{ text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint",
	{ text = "", texthl = "DiagnosticSignHint" })

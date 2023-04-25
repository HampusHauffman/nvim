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

-- Terminal
link("Terminal", "Pmenu")

-- Border
link("TelescopeBorder", "TelescopePromptBorder")
link("WinSeparator", "TelescopePromptBorder")

-- StatusLine
link("StatusLine", "Normal")

-- Lualine
--link("lualine_c_normal", "Normal")
--link("lualine_c_insert", "lualine_c_normal")
--link("lualine_c_visual", "lualine_c_normal")
--link("lualine_c_command", "lualine_c_normal")
--link("lualine_c_replace", "lualine_c_normal")
--link("lualine_c_inactive", "lualine_c_normal")


link("NeoTreeTabActive", "Normal")
link("NeoTreeTabSeparatorActive", "Normal")
link("NeoTreeTabInactive", "Pmenu")
link("NeoTreeTabSeparatorInactive", "Pmenu")

-- IndentLines
link("IndentBlankLineContextChar", "Underline")

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

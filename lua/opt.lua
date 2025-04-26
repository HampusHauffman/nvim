-- Set options (global/buffer/windows-scoped)
local opt = vim.opt
opt.clipboard = "unnamedplus"

opt.wrap = true -- Disable line wrap
opt.number = true -- Show line number
opt.relativenumber = true --relativenumber
opt.undofile = true -- Persistent undo
opt.smartindent = true -- Autoindent new lines
opt.autoindent = true
opt.splitright = true -- Split to the right

-- StatusLine
opt.laststatus = 3 -- Set global statusline
opt.cmdheight = 0
--Test
opt.diffopt =
  "internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram"

-- Border for diagnostic
vim.diagnostic.config({
  float = { border = "rounded" },
})

-- Make the separator purple
--vim.api.nvim_command(
--  "hi! link " .. "NeoTreeWinSeparator" .. " " .. "@enumMember"
--)
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#020202" })
vim.api.nvim_command("hi! link " .. "WinSeparator" .. " " .. "@enumMember")
--vim.api.nvim_command("hi! link " .. "FzfLuaBorder" .. " " .. "@enumMember")
--vim.api.nvim_command("hi! link " .. "FzfLuaCursorLine" .. " " .. "Normal")
--vim.api.nvim_command("hi! link " .. "FzfLuaSearch" .. " " .. "Normal")

vim.fn.sign_define(
  "DiagnosticSignError",
  { text = " ", texthl = "DiagnosticSignError" }
)
vim.fn.sign_define(
  "DiagnosticSignWarn",
  { text = " ", texthl = "DiagnosticSignWarn" }
)
vim.fn.sign_define(
  "DiagnosticSignInfo",
  { text = " ", texthl = "DiagnosticSignInfo" }
)
vim.fn.sign_define(
  "DiagnosticSignHint",
  { text = "󰌵", texthl = "DiagnosticSignHint" }
)

-- Set options (global/buffer/windows-scoped)
local opt = vim.opt
opt.clipboard = "unnamedplus"

opt.wrap = true -- Disable line wrap
opt.number = true -- Show line number
opt.relativenumber = true --relativenumber
opt.undofile = true -- Persistent undo
opt.smartindent = true -- Autoindent new linespt.smartindent = true      -- Autoindent new lines

-- StatusLine
opt.laststatus = 3 -- Set global statusline
opt.cmdheight = 0

-- Border for diagnostic
vim.diagnostic.config({
  float = { border = "rounded" },
})

-- Make the separator purple
vim.api.nvim_command(
  "hi! link " .. "NeoTreeWinSeparator" .. " " .. "@enumMember"
)

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

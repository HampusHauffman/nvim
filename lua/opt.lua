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
-- opt.laststatus = 0 -- Set global statusline
opt.laststatus = 3 -- Set global statusline
opt.cmdheight = 0
vim.o.cmdwinheight = 3

--Test
opt.diffopt =
  "internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram"

vim.o.ignorecase = true -- Ignore case in search patterns
vim.o.smartcase = true -- Smart case
vim.o.signcolumn = "yes:1"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.virtualedit = "block"
--vim.o.mopt = "wait:500,history:500" -- Show any "enter" mess for half a sec then remove
vim.o.shortmess = "ltToOCFsqS"

-- This messes with some other plugins
vim.g.snacks_animate = false
-- Border for diagnostic
vim.diagnostic.config({
  virtual_text = true,
  float = { border = "rounded" },
})

vim.fn.sign_define(
  "DiagnosticSignError",
  { text = "", texthl = "DiagnosticSignError" }
) -- X
vim.fn.sign_define(
  "DiagnosticSignWarn",
  { text = "", texthl = "DiagnosticSignWarn" }
) -- warning triangle
vim.fn.sign_define(
  "DiagnosticSignInfo",
  { text = "", texthl = "DiagnosticSignInfo" }
) -- info circle
vim.fn.sign_define(
  "DiagnosticSignHint",
  { text = "", texthl = "DiagnosticSignHint" }
) -- lightbulb

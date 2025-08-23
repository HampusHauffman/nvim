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
  update_in_insert = true,
  virtual_text = true,
  float = { border = "rounded" },
  severity_sort = { reverse = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
  },
})

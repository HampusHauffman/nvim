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
opt.cmdwinheight = 3

--Test
opt.diffopt =
  "internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram"

opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Smart case
opt.signcolumn = "yes:1"
opt.foldmethod = "expr"
opt.foldlevel = 1
opt.foldenable = false -- Use zi to enable folds
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

_G.FoldText = function()
  local api = vim.api
  local fn = vim.fn
  -- This is the content of the first line of the fold
  local folded_lines =
    api.nvim_buf_get_lines(0, vim.v.foldstart - 1, vim.v.foldend, true)
  -- Get the width of the current window.
  --
  local win_width = api.nvim_win_get_width(0)

  local text = folded_lines[1]

  local line_count_text = " " .. #folded_lines .. " 󰊠  "

  text = text .. "  ┄╌"
  line_count_text = "╌┄  " .. line_count_text

  -- Calculate the number of dashes needed to fill the remaining space.
  local available_width = win_width
    - fn.strdisplaywidth(text)
    - fn.strdisplaywidth(line_count_text)
    - 6

  local dashes = ""
  dashes = string.rep("─", available_width)

  -- Construct and return the final fold text.
  return text .. dashes .. line_count_text
end

vim.o.foldtext = "v:lua.FoldText()"
-- FoldText is the function name
opt.virtualedit = "block"
--opt.mopt = "wait:500,history:500" -- Show any "enter" mess for half a sec then remove
opt.shortmess = "ltToOCFsqS"

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
      -- [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      -- [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      -- [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      -- [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
  },
})

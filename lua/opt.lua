local opt = vim.opt

opt.clipboard = "unnamedplus"

opt.wrap = true
opt.number = true
opt.relativenumber = true
opt.undofile = true
opt.autowriteall = true
opt.smartindent = true
opt.autoindent = true
opt.splitright = true
opt.laststatus = 3
opt.cmdheight = 0
opt.cmdwinheight = 3
opt.diffopt = "internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram"
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes:2"
opt.foldmethod = "expr"
opt.foldlevel = 3
opt.foldenable = false
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

_G.FoldText = function()
  local text = vim.fn.getline(vim.v.foldstart) .. "  ┄╌"
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  local suffix = "╌┄   " .. line_count .. " 󰊠  "
  local width = vim.api.nvim_win_get_width(0)
      - vim.fn.strdisplaywidth(text)
      - vim.fn.strdisplaywidth(suffix)
      - 6

  return text .. string.rep("─", math.max(0, width)) .. suffix
end

opt.foldtext = "v:lua.FoldText()"
opt.virtualedit = "block"
opt.shortmess = "ltToOCFsqS"

vim.g.snacks_animate = false

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
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
  },
})

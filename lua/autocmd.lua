-- Don't auto commenting new lines
local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup

au("BufEnter", {
    pattern = "*",
    command = "set fo-=c fo-=r fo-=o",
})

au('TextYankPost', {
  group = ag('yank_highlight', {}),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup='IncSearch', timeout=3000 }
  end,
})


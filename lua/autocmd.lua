
vim.cmd [[au BufEnter * nested hi TSProperty guifg=#FFB86C]]
vim.cmd [[au BufEnter * nested hi TSVariable guifg=#BD9F39]]

-- Don't auto commenting new lines
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})

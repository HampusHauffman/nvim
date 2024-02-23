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
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 3000 }
  end,
})

function ClearReg()
  print('Clearing registers')
  vim.cmd [[
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
    for r in regs
    call setreg(r, [])
    endfor
]]
end

--Make it so i can call ClearReg as a command
vim.api.nvim_create_user_command('ClearReg', function()
  ClearReg()
end, {})

vim.cmd [[
        augroup jdtls_lsp
            autocmd!
            autocmd FileType java lua require'jdtls.jdtls_setup'.setup()
        augroup end
        ]]

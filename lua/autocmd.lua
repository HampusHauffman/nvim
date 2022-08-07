-- Disable Neotree legacy commands
vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

-- Runs Neotree show when VimEnter
--vim.cmd([[au PackerCompileDone * nested Neotree show]])
vim.cmd [[au VimEnter * nested Neotree show]]

-- Treesitter set color (Probably a better way of doing this)
--vim.cmd [[au BufEnter * nested hi TSParameter guifg=#ABB2BF]]
--vim.cmd [[au BufEnter * nested hi TSProperty guifg=#FFB86C]]
--vim.cmd [[au BufEnter * nested hi TSVariable guifg=#BD9F39]]


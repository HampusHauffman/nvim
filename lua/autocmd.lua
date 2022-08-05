-- Disable Neotree legacy commands
vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

-- Runs Neotree show when VimEnter
--vim.cmd([[au PackerCompileDone * nested Neotree show]])
vim.cmd [[au VimEnter * nested Neotree show]]


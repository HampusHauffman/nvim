local function map(mode, lhs, rhs, desc)
  local options = { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Disable arrow keys to be 1337
map("", "<up>", "<nop>")
map("", "<down>", "<nop>")
map("", "<left>", "<nop>")
map("", "<right>", "<nop>")

-- Move to end with ö
map("n", "ö", "$")
map("v", "ö", "$")

-- Map Esc to kk and jj
map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")

-- Move in insert mode
map("i", "<C-h>", "<left>")
map("i", "<C-j>", "<down>")
map("i", "<C-k>", "<up>")
map("i", "<C-l>", "<right>")

vim.cmd([[
  set wildcharm=<Tab>
  cnoremap <C-j> <Tab>
  cnoremap <C-k> <S-Tab>
]])

-- Fast saving with <leader> and s
map("n", "<leader>s", ":w<CR>", "Save file 💾")

-- Allows Option backspace to delete words
map("i", "<M-BS>", "<Esc> hciw", "Remove Word")

-- So that whenever i am in visual mode and press p, it pastes from the system clipboard / last yank
--map("v", "p", '"0p')

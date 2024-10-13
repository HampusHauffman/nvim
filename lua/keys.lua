
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

-- Move around splits using Ctrl + {h,j,k,l}
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

vim.cmd([[
  set wildcharm=<Tab>
  cnoremap <C-j> <Tab>
  cnoremap <C-k> <S-Tab>
]])

-- Fast saving with <leader> and s
map("n", "<leader>s", ":w<CR>", "Save file 💾")



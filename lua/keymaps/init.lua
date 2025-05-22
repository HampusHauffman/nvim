-- All the keybinds are located under /keymaps to allow ease of configuration of these
local M = {}

---@param mode string|string[] Mode or modes for which the keymap is effective
---@param lhs string Left-hand side of the mapping
---@param rhs string|function Right-hand side of the mapping
---@param desc string Optional description
local function map(mode, lhs, rhs, desc)
  local options = { noremap = true, silent = true, desc = desc }
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Disable arrow keys to be 1337
map("", "<up>", "<nop>", "Disable up arrow")
map("", "<down>", "<nop>", "Disable down arrow")
map("", "<left>", "<nop>", "Disable left arrow")
map("", "<right>", "<nop>", "Disable right arrow")

-- Move to end with ö
map("n", "ö", "$", "Move to end of line")
map("v", "ö", "$", "Move to end of line")

-- Map Esc to kj and jk
map("i", "jk", "<Esc>", "Exit insert mode")
map("i", "kj", "<Esc>", "Exit insert mode")

-- Move in insert mode
map("i", "<C-h>", "<left>", "Move left")
map("i", "<C-j>", "<down>", "Move down")
map("i", "<C-k>", "<up>", "Move up")
map("i", "<C-l>", "<right>", "Move right")

-- No work keys
map("n", "<leader>gh", "vgh", "Select hunk")
map("n", "<leader>gR", "vghgr", "Reset hunk")
map("n", "ga", "ggVG", "Select all")

-- Fast saving with <leader> and s
map("n", "<leader>s", ":silent w<CR>", "Save file 💾")

-- Allows Option backspace to delete words
map("i", "<M-BS>", "<Esc> hciw", "Remove Word")

-- Command mode mappings
vim.cmd([[
    set wildcharm=<Tab>
    cnoremap <C-j> <Tab>
    cnoremap <C-k> <S-Tab>
  ]])

return M

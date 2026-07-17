---@class KeymapSpec: vim.keymap.set.Opts
---@field [1] string
---@field [2] string|function
---@field mode? string|string[]

local M = {}

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

---@param keys KeymapSpec[]
function M.set(keys)
  for _, key in ipairs(keys) do
    vim.keymap.set(key.mode or "n", key[1], key[2], {
      desc = key.desc,
      nowait = key.nowait,
      silent = true,
    })
  end
end

map({ "n", "v" }, "ö", "$", "Move to end of line")

map("i", "jk", "<Esc>", "Exit insert mode")
map("i", "kj", "<Esc>", "Exit insert mode")

map("i", "<C-h>", "<left>", "Move left")
map("i", "<C-j>", "<down>", "Move down")
map("i", "<C-k>", "<up>", "Move up")
map("i", "<C-l>", "<right>", "Move right")

map("n", "<C-Left>", function()
  vim.cmd("vertical resize -" .. vim.v.count1)
end, "Decrease window width")

map("n", "<C-Down>", function()
  vim.cmd("resize -" .. vim.v.count1)
end, "Decrease window height")

map("n", "<C-Up>", function()
  vim.cmd("resize +" .. vim.v.count1)
end, "Increase window height")

map("n", "<C-Right>", function()
  vim.cmd("vertical resize +" .. vim.v.count1)
end, "Increase window width")

map(
  "v",
  "/",
  [[y/\V<C-r>=escape(@",'/\')<CR><CR>]]
)

map("n", "<leader>gh", "vgh", "Select hunk")
map("n", "<leader>gR", "vghgr", "Reset hunk")
map("n", "ga", "ggVG", "Select all")
map("n", "<leader>s", "<cmd>silent write<cr>", "Save file 💾")
map("i", "<M-BS>", "<C-w>", "Delete previous word")
map("n", ";", "q:i", "Command window")

map("n", "<leader>w", require("keymaps.commands").open, "Commands")

return M

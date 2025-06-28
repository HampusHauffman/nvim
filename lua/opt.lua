-- Set options (global/buffer/windows-scoped)
local opt = vim.opt
opt.clipboard = "unnamedplus"

opt.wrap = true -- Disable line wrap
opt.number = true -- Show line number
opt.relativenumber = true --relativenumber
opt.undofile = true -- Persistent undo
opt.smartindent = true -- Autoindent new lines
opt.autoindent = true
opt.splitright = true -- Split to the right

-- StatusLine
-- opt.laststatus = 0 -- Set global statusline
opt.laststatus = 3 -- Set global statusline
opt.cmdheight = 0
--Test
opt.diffopt =
  "internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram"

vim.o.ignorecase = true -- Ignore case in search patterns
vim.o.smartcase = true -- Smart case
vim.o.signcolumn = "yes:1"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Border for diagnostic
vim.diagnostic.config({
  --virtual_lines = true,
  virtual_text = true,
  float = { border = "rounded" },
})

vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#020202" })
--vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#00FF00" })
--vim.api.nvim_set_hl(0, "WinSeparator", { link = "@enumMember" })
vim.api.nvim_set_hl(0, "Pmenu", { link = "Normal" })
--vim.api.nvim_set_hl(0, "SignColumn", { bg = "#00FF00", fg = "#FF0000" })
-- Fix color for Search
vim.api.nvim_set_hl(0, "Search", { bg = "none", fg = "none", underline = true })
vim.api.nvim_set_hl(
  0,
  "IncSearch",
  { bg = "none", fg = "none", underline = true }
)
vim.api.nvim_set_hl(
  0,
  "CurSearch",
  { bg = "none", fg = "none", underline = true }
)
--vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" ,fg="none", underline = true})

vim.fn.sign_define(
  "DiagnosticSignError",
  { text = "", texthl = "DiagnosticSignError" }
) -- X
vim.fn.sign_define(
  "DiagnosticSignWarn",
  { text = "", texthl = "DiagnosticSignWarn" }
) -- warning triangle
vim.fn.sign_define(
  "DiagnosticSignInfo",
  { text = "", texthl = "DiagnosticSignInfo" }
) -- info circle
vim.fn.sign_define(
  "DiagnosticSignHint",
  { text = "", texthl = "DiagnosticSignHint" }
) -- lightbulb

vim.api.nvim_create_user_command("Messages", function()
  -- Get messages content
  local messages = vim.api.nvim_cmd({ cmd = "messages" }, { output = true })

  -- Calculate dimensions
  local width = math.min(vim.o.columns - 4, 200)
  local height = math.min(vim.o.lines - 4, 40)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(messages, "\n"))

  -- Set buffer options
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = "wipe"

  -- Open float
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " Neovim Messages ",
    title_pos = "center",
  })

  -- Add keymaps to close the float
  vim.api.nvim_buf_set_keymap(
    buf,
    "n",
    "q",
    ":close<CR>",
    { noremap = true, silent = true }
  )

  vim.api.nvim_buf_set_keymap(
    buf,
    "n",
    "<Esc>",
    ":close<CR>",
    { noremap = true, silent = true }
  )
end, {})

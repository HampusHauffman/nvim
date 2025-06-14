-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Leader key
vim.g.mapleader = " "

---@class LazyConfig
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
    --{
    --  "HampusHauffman/dracula.nvim",
    --  dev = true,
    --  branch = "oled",
    --  priority = 1000,
    --},
    {
      "Mofiqul/dracula.nvim",
      opts = {
        theme = "dracula-soft",
        colors = {
          bg = "#000000",
          black = "#000000",
          visual = "#3E4452",
        },
        show_end_of_buffer = true, -- default false
        transparent_bg = true, -- default false
        lualine_bg_color = "#000000", -- default nil
        italic_comment = true, -- default false
        overrides = {},
      },
    },
    {
      "HampusHauffman/block.nvim",
      dev = true,
      percent = 1.2,
      priority = 1000,
      opts = {
        percent = 1.4,
        depth = 4,
        bg = "#101010",
        automatic = false,
        colors = { "#00ff00", "#ff0000", "#0000ff" },
      },
    },
  },
  install = { colorscheme = { "dracula-soft" } },
  checker = {
    notify = false, -- get a notification when new updates are found
  },
  ---@diagnostic disable-next-line: assign-type-mismatch
  dev = { path = "~/Documents" },
  ui = {
    border = "rounded",
  },
})

--vim.cmd("colorscheme dracula-soft")
vim.cmd("colorscheme dracula-soft")
require("opt")
require("keymaps")
require("aucmd")

-- Activate manual lsp
--vim.lsp.enable("gdshader-lsp")
vim.lsp.enable("kotlin-ls")
-- Enable true colors and show number/sign columns
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.signcolumn = "yes"

-- Set LineNr background to magenta
--vim.api.nvim_set_hl(0, "LineNr", { bg = "#FF00FF" })

-- Replace tildes (~) with full block and make it magenta too
vim.opt.fillchars:append({ eob = "█" }) -- U+2588 FULL BLOCK
vim.api.nvim_set_hl(0, "EndOfBuffer", { link = "@number" })

-- Define the sign (only needs to be done once)
vim.fn.sign_define("LowPrioSign", {
  text = "█", -- appearance in sign column
  texthl = "@number", -- highlight group
})

-- Define the function to (re)place signs
local function peacock()
  local bufnr = vim.api.nvim_get_current_buf()
  local line_count = vim.api.nvim_buf_line_count(bufnr)

  -- Clear existing signs in the "lowprio" group for this buffer
  vim.fn.sign_unplace("lowprio", { buffer = bufnr })

  -- Place signs on each line
  for i = 1, line_count do
    vim.fn.sign_place(
      i, -- use line number as ID for simplicity
      "lowprio",
      "LowPrioSign",
      bufnr,
      { lnum = i, priority = 1 }
    )
  end
end

-- Create an autocmd group
local group = vim.api.nvim_create_augroup("Peacock", { clear = true })

-- Create the autocmd on TextChanged
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  group = group,
  callback = function()
    pcall(peacock)
  end,
})

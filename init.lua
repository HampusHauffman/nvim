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
      opts = { percent = 1.4, depth = 4, bg = "#101010", automatic = false },
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
require("keys")
require("aucmd")

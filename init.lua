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
    {
      "HampusHauffman/dracula.nvim",
      dev = true,
      branch = "oled",
      priority = 1000,
    },
  },
  install = { colorscheme = { "dracula" } },
  checker = { enabled = true },
  ---@diagnostic disable-next-line: assign-type-mismatch
  dev = { path = "~/Documents" },
  ui = {
    border = "rounded",
  },
})

--vim.cmd("colorscheme dracula-soft")
vim.cmd("colorscheme dracula")
require("opt")
require("keys")
require("aucmd")

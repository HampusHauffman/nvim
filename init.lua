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
vim.g.maplocalleader = " "
--vim.cmd("colorscheme dracula-soft")
require("opt")
require("keymaps")
require("aucmd")

---@class LazyConfig
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      ---@type CatppuccinOptions
      opts = {
        flavour = "mocha",
        lsp_styles = {
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        -- auto_integrations = true,
        color_overrides = {
          all = {
            base = "#000000",
            mantle = "#000000",
            crust = "#000000",
          },
        },
        custom_highlights = function(colors)
          return {
            ["@variable"] = { fg = colors.pink },
            ["@function.call.gdscript"] = { fg = colors.mauve },
            ["WinSeparator"] = { fg = colors.blue },
            -- ["@property"] = { fg = colors.peach },
            -- ["@member"] = { fg = colors.peach },
            -- ["Function"] = { fg = colors.peach },
          }
        end,
        integrations = {
          alpha = true,
          cmp = true,
          dashboard = true,
          flash = true,
          fzf = true,
          grug_far = true,
          gitsigns = true,
          indent_blankline = { enabled = true },
          leap = true,
          lsp_trouble = true,
          mason = true,
          mini = true,
          neotest = true,
          noice = true,
          notify = true,
          snacks = true,
          treesitter_context = true,
          which_key = true,
        },
      },
    },
    {
      "HampusHauffman/block.nvim",
      dev = true,
      --enabled = false,
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
    performance = {

      rtp = {
        -- disable some rtp plugins
        disabled_plugins = {
          "gzip",
          -- "matchit",
          -- "matchparen",
          -- "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
  },
  checker = {
    notify = true, -- get a notification when new updates are found
  },
  ---@diagnostic disable-next-line: assign-type-mismatch
  dev = { path = "~/Documents" },
  ui = {
    border = "rounded",
  },
})

 vim.filetype.add({
    extension = {
    gdshader = "gdshader",
  },
})

vim.cmd.colorscheme("catppuccin-mocha")

---@type LazyPluginSpec[]
local M = {}

M[#M + 1] = { "Bilal2453/luvit-meta", lazy = true }

M[#M + 1] = {
  "folke/lazydev.nvim",
  ft = "lua",
  cmd = "LazyDev",
  opts = {
    library = {
      { path = "luvit-meta/library", words = { "vim%.uv" } },
      { path = "lazy.nvim" },
      { path = "snacks.nvim" },
      { path = "flash.nvim" },
      { path = "catppuccin" },
      { path = "nvim-dap" },
    },
  },
}

M[#M + 1] = {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  opts = {},
}

M[#M + 1] = {
  "tpope/vim-sleuth",
  event = { "BufReadPost", "BufNewFile" },
}

M[#M + 1] = {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    explorer = {
      replace_netrw = true,
      auto_close = true,
    },
    input = {
      enabled = true,
    },
    picker = {
      ui_select = true,
    },
    zen = {
      win = { backdrop = { transparent = false, blend = 99 } },
      on_open = function()
        require("mini.diff").disable(0)
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
      end,
      on_close = function()
        require("mini.diff").enable(0)
        vim.opt_local.number = true
        vim.opt_local.relativenumber = true
      end,
    },
    indent = { enabled = true },
    chunk = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    words = { enabled = true },
  },
}

return M

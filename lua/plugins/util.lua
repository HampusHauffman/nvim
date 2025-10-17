---@type LazyPluginSpec[]
local M = {}

-- Manage libuv types with lazy. Plugin will never be loaded
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
      { path = "noice.nvim" },
      { path = "flash.nvim" },
      { path = "blink.nvim" },
    },
  },
}

--M[#M + 1] = { "echasnovski/mini.pairs", version = "*", opts = {} }

M[#M + 1] = {
  "MagicDuck/grug-far.nvim",
  cmd = { "GrugFar" },
  config = function()
    require("grug-far").setup({})
  end,
}

M[#M + 1] = { "tpope/vim-sleuth", event = { "BufReadPost", "BufNewFile" } }

M[#M + 1] = {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    explorer = {
      replace_netrw = false, -- Replace netrw with the snacks explorer
      auto_close = true,
    },
    input = {
      enabled = true,
      win = { style = "input" },
    },
    picker = { ui_select = true },
    zen = {
      toggles = {},
      win = { backdrop = { transparent = false, blend = 99 } },
    },
    indent = {
      enabled = true,
      only_scope = false, -- only show indent guides of the scope
    },
    chunk = { enabled = true },
    scope = { enabled = true },

    scroll = { enabled = true },
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        --header = [[ ]]
      },
      sections = {
        {
          section = "terminal",
          cmd = "cat " .. vim.fn.stdpath("config") .. "/header_art",
          indent = 8,
          height = 22,
          random = 100,
        },
        --{ section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    words = { enabled = true },
    styles = {
      zen = {
        backdrop = { transparent = false, blend = 40 },
      },
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
  },
}

return M

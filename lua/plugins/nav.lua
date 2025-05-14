---@type LazyPluginSpec[]
local M = {}
M[#M + 1] = {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = require("keymaps.nav").tmux,
}

M[#M + 1] = {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    modes = {
      char = { enabled = false }, -- Disables default keys (F, f, T, t) so i can use S
    },
  },
  -- Use centralized keymaps
  keys = require("keymaps.nav").flash,
}

-- Import navigation keys from centralized location
---@type LazyKeysSpec[]
local navKeys = require("keymaps.nav").keys

M[#M + 1] = {
  "folke/snacks.nvim",
  priority = 1000,
  keys = navKeys,
}
return M

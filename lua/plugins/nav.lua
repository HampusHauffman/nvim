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

return M

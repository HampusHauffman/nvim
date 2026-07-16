local keys = require("keymaps.nav")

---@type LazyPluginSpec[]
local M = {}

M[#M + 1] = {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = keys.tmux,
}

M[#M + 1] = {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
      char = { enabled = false },
      treesitter = {
        labels = "",
      },
    },
  },
  keys = keys.flash,
}

M[#M + 1] = {
  "folke/snacks.nvim",
  keys = keys.keys,
}

return M

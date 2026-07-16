local keymaps = require("keymaps.git")

---@type LazyPluginSpec[]
local M = {}

M[#M + 1] = {
  "echasnovski/mini.diff",
  event = "VeryLazy",
  keys = keymaps.diff,
  opts = {
    mappings = {
      apply = "<leader>ga",
      reset = "<leader>gr",
      textobject = "gh",
      goto_prev = "<leader>gp",
      goto_next = "<leader>gn",
    },
    view = {
      style = "sign",
      signs = {
        add = "▎",
        change = "▎",
        delete = "_",
      },
    },
  },
}

M[#M + 1] = { "sindrets/diffview.nvim", opts = {} }

M[#M + 1] = {
  "folke/snacks.nvim",
  keys = keymaps.keys,
}

return M

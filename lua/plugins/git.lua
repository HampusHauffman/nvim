---@type LazyPluginSpec[]
local M = {}
local keys = require("keymaps.git")
M[#M + 1] = {
  "echasnovski/mini.diff",
  event = "VeryLazy",
  keys = keys.diff,
  config = function()
    require("mini.diff").setup({
      mappings = keys.diff_mappings,
      view = {
        style = "sign",
        signs = {
          add = "▎",
          change = "▎",
          delete = "_",
        },
      },
    })
  end,
}

M[#M + 1] = { "sindrets/diffview.nvim", opts = {} }

---@type LazyKeysSpec[]

M[#M + 1] = {
  "folke/snacks.nvim",
  priority = 1000,
  keys = keys.keys,
}

return M

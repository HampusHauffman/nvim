---@type LazyPluginSpec[]
local M = {}
M[#M + 1] = {
  "echasnovski/mini.diff",
  event = "VeryLazy",
  keys = require("keymaps.git").diff,

  config = function()
    require("mini.diff").setup({
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
          delete = "",
        },
      },
    })
  end,
}

---@type LazyKeysSpec[]
local gitKeys = require("keymaps.git").keys

M[#M + 1] = {
  "folke/snacks.nvim",
  priority = 1000,
  keys = gitKeys,
}

return M

---@type LazyPluginSpec[]
local M = {}
local keys = require("keymaps.git")
M[#M + 1] = {
  "echasnovski/mini.diff",
  event = "VeryLazy",
  keys = keys.diff,
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

M[#M + 1] = {
  "folke/snacks.nvim",
  priority = 1000,
  keys = keys.keys,
}

return M

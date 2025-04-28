---@type LazyPluginSpec[]
local M = {}
M[#M + 1] = {
  "echasnovski/mini.diff",
  event = "VeryLazy",
  keys = {
    {
      "<leader>go",
      function()
        require("mini.diff").toggle_overlay(0)
      end,
      desc = "Toggle mini.diff overlay",
    },
  },

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

return M

---@type LazyPluginSpec[]
local M = {}

M[#M + 1] = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    win = { border = "rounded" },
    triggers = {
      { "<auto>", mode = "nixsotc" },
      { "<leader>", mode = { "n", "v" } },
      { "f", mode = { "n", "v" } },
      { "g", mode = { "n", "v" } },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}

return M

local M = {}

--M[#M + 1] = {
--  "zbirenbaum/copilot.lua",
--  cmd = "Copilot",
--  event = "InsertEnter",
--  config = function()
--    require("copilot").setup({
--      suggestion = { enabled = false },
--      panel = { enabled = false },
--      copilot_model = "gpt-4o-copilot",
--    })
--  end,
--}

M[#M + 1] = {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  lazy = false,
  config = true,
  opts = {
    adapters = {
      opts = {
        show_defaults = false,
      },
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              --default = "gpt-4",
              default = "claude-3.7-sonnet",
            },
          },
        })
      end,
    },
    display = {
      chat = { show_settings = true },
      diff = {
        provider = "mini_diff",
      },
    },
  },
  keys = require("keymaps.ai").keys,
}

return M

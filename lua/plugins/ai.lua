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

-- Adapters: https://github.com/olimorris/codecompanion.nvim/tree/main/lua/codecompanion/adapters
M[#M + 1] = {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  lazy = false,
  config = true,
  opts = {
    strategies = {
      chat = {
        adapter = "gemini",
      },
      inline = {
        adapter = "gemini",
      },
    },
    adapters = {
      opts = {
        show_defaults = false,
      },
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          schema = {
            default = "gemini-2.5-pro",
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

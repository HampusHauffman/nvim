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

-- For both codecompanion and minuet the API key for gemeni is stored under env: GEMINI_API_KEY (Default for both)
-- Test this for gemini autocomplete: https://github.com/milanglacier/minuet-ai.nvim
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
        adapter = "openai",
      },
      inline = {
        adapter = "openai",
      },
    },
    adapters = {
      opts = {
        show_defaults = false,
      },
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          schema = {
            model = {
              default = "gemini-2.5-pro",
            },
          },
        })
      end,
      openai = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          env = {
            url = "https://zllm.data.zalan.do",
            api_key = function()
              return vim.fn.trim(vim.fn.system("ztoken"))
            end,
            chat_url = "/v1/chat/completions",
          },
          schema = {
            model = {
              default = "bedrock/anthropic.claude-sonnet-4-20250514-v1:0",
            },
            temperature = {
              default = 0.3,
            },
            max_completion_tokens = {
              default = 8000,
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

M[#M + 1] = {
  "milanglacier/minuet-ai.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    provider = "gemini",
    provider_options = {
      gemini = {
        model = "gemini-2.0-flash",
      },
    },
  },
}

return M

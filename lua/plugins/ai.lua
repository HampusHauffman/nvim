local M = {}
local ztoken = nil

M[#M + 1] = {
  "zbirenbaum/copilot.lua",
  dependencies = {
    "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
  },
  opts = {},
}

M[#M + 1] = {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  lazy = true,
  config = true,
  keys = require("keymaps.ai").keys,
}

M[#M + 1] = {
  "milanglacier/minuet-ai.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    provider = "openai_compatible",
    provider_options = {
      openai_compatible = {
        model = "bedrock/anthropic.claude-3-haiku-20240307-v1:0",
        --api_key = get_ztoken, -- Calling this like this gives a bit of a delay
        end_point = "https://zllm.data.zalan.do/v1/chat/completions",
        body = {
          n = 2,
        },
      },
    },
  },
}

return M

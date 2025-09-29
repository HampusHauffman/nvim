local M = {}
local ztoken = nil

-- Asynchronously fetch the token on startup.
--vim.fn.jobstart("ztoken", {
--  on_stdout = function(_, data)
--    if data and #data > 0 and data[1] ~= "" then
--      ztoken = vim.fn.trim(data[1])
--    end
--  end,
--})

--local function get_ztoken()
--  -- If the token is not ready yet from the async call,
--  -- block and fetch it synchronously as a fallback.
--  if not ztoken then
--    ztoken = vim.fn.trim(vim.fn.system("ztoken"))
--  end
--  return ztoken
--end

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

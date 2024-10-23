---@type LazyPluginSpec[]
local M = {}

M[#M + 1] = {
  "github/copilot.vim",
  cmd = "Copilot",
  event = "InsertEnter",
}

--M[#M + 1] = {
--  "CopilotC-Nvim/CopilotChat.nvim",
--  branch = "canary",
--  dependencies = {
--    { "github/copilot.vim" }, -- or github/copilot.vim
--    { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
--  },
--  build = "make tiktoken", -- Only on MacOS or Linux
--  opts = {
--    debug = false, -- Enable debugging
--  },
--
--  ---@type LazyKeysSpec[]
--  keys = {
--    -- Show help actions with telescope
--    {
--      "<leader>gh",
--      function()
--        local actions = require("CopilotChat.actions")
--        require("CopilotChat.integrations.telescope").pick(
--          actions.help_actions()
--        )
--      end,
--      desc = "CopilotChat - Help actions",
--    },
--    -- Show prompts actions with telescope
--    {
--      "<leader>gp",
--      function()
--        local actions = require("CopilotChat.actions")
--        require("CopilotChat.integrations.telescope").pick(
--          actions.prompt_actions()
--        )
--      end,
--      desc = "CopilotChat - Prompt actions",
--    },
--    {
--      "<leader>gq",
--      function()
--        local input = vim.fn.input("Quick Chat: ")
--        if input ~= "" then
--          require("CopilotChat").ask(
--            input,
--            { selection = require("CopilotChat.select").buffer }
--          )
--        end
--      end,
--      desc = "CopilotChat - Quick chat",
--    },
--  },
--}

return M

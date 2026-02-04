local M = {}
local ztoken = nil

-- M[#M + 1] = {
--   "zbirenbaum/copilot.lua",
--   dependencies = {
--     "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
--   },
--   --cmd = "Copilot",
--   --event = "InsertEnter",
--   opts = {
--     disable_limit_reached_message = true, -- Set to `true` to suppress completion limit reached popup
--   },
-- }

-- M[#M + 1] = {
--   "olimorris/codecompanion.nvim",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     --"nvim-treesitter/nvim-treesitter",
--   },
--   lazy = true,
--   config = true,
--   keys = require("keymaps.ai").keys,
-- }

return M

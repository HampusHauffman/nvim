---@type LazyPluginSpec[]
local M = {}
M[#M + 1] = {
  "echasnovski/mini.diff",
  event = "VeryLazy",
  config = function()
    require("mini.diff").setup()
  end,
}
return M

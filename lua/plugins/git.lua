---@type LazyPluginSpec[]
local M = {}
M[#M + 1] = {
  "echasnovski/mini.diff",
  event = "VeryLazy",
  config = function()
    require("mini.diff").setup({
      mappings = {
        apply = "<leader>ga",
        reset = "<leader>gr",
        textobject = "gh",
        goto_prev = "<leader>gp",
        goto_next = "<leader>gn",
      },
    })
  end,
}
return M

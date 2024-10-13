---@type LazyPluginSpec[]
local M = {}

M[#M + 1] = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>n", ":Neotree left focus reveal<CR>", "File explorer" },
  },
}

return M

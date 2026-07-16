---@type LazyPluginSpec[]
local M = {}

M[#M + 1] = {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "vimdoc",
      "query",
      "markdown",
      "c",
    },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  },
}

return M

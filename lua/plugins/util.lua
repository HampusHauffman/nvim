---@type LazyPluginSpec[]
local M = {}

-- Manage libuv types with lazy. Plugin will never be loaded
M[#M + 1] = { "Bilal2453/luvit-meta", lazy = true }

M[#M + 1] = {
  "folke/lazydev.nvim",
  ft = "lua",
  cmd = "LazyDev",
  opts = {
    library = {
      { path = "luvit-meta/library", words = { "vim%.uv" } },
      { path = "lazy.nvim" },
    },
  },
}

M[#M + 1] = { "echasnovski/mini.pairs", version = "*", opts = {} }

M[#M + 1] = {
  "MagicDuck/grug-far.nvim",
  config = function()
    require("grug-far").setup({
      -- options, see Configuration section below
      -- there are no required options atm
      -- engine = 'ripgrep' is default, but 'astgrep' can be specified
    })
  end,
}

return M

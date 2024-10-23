---@type LazyPluginSpec[]
local M = {}

M[#M + 1] = {
  "NvChad/nvim-colorizer.lua",
  opts = {},
}

M[#M + 1] = {
  "nvim-lualine/lualine.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  opts = {
    options = {
      theme = "dracula-nvim",
      extensions = { "quickfix" },
      component_separators = "  ",
      section_separators = { left = "", right = "" },
      globalstatus = true,
      disabled_filetypes = {
        winbar = { "neo-tree", "terminal", "toggleterm" },
      },
    },
    sections = {
      lualine_a = {
        { "mode", separator = { left = "  " }, right_padding = 2 },
      },
      lualine_b = {
        { "filename", icon = { "", align = "left" } },
        "branch",
      },
      lualine_x = {},
      lualine_y = { "filetype", "progress" },
      lualine_z = {
        { "location", separator = { right = "  " }, left_padding = 2 },
      },
    },
  },
}

return M

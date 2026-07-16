---@type LazyPluginSpec[]
local M = {}

M[#M + 1] = {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown",
}

M[#M + 1] = {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    enable_tailwind = true,
  },
}

M[#M + 1] = {
  "nvim-treesitter/nvim-treesitter-context",
  opts = {},
}

M[#M + 1] = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
      globalstatus = true,
    },
    sections = {
      lualine_a = {
        {
          "mode",
          separator = { left = "", right = "" },
        },
      },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = {
        { "filename" },
        { "lsp_status", padding = 4 },
        {
          function()
            local reg = vim.fn.reg_recording()
            return reg ~= "" and ("  @" .. reg) or ""
          end,
          color = { fg = "#ff9e64" },
        },
      },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  },
}

return M

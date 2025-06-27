---@type LazyPluginSpec[]
local M = {}
M[#M + 1] = { "arkav/lualine-lsp-progress" }

M[#M + 1] = {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "codecompanion" },
}

M[#M + 1] = {
  "hampushauffman/peacock.nvim",
  dir = "~/Documents/peacock.nvim",
  name = "peacock",
  lazy = false,
  {
    "hampushauffman/peacock.nvim",
    dependencies = { "nvim-lualine/lualine.nvim" },
    dir = "~/Documents/peacock.nvim",
    name = "peacock",
    dev = true,
    config = function()
      require("peacock").setup({
        --sign_column_width = 1,
        --bar_enabled = false,
        --eob_enabled = false,
      })

      -- Now that the plugin is set up and highlights exist, you can link or override them:
      local nvim_set_hl = vim.api.nvim_set_hl
      nvim_set_hl(0, "WinSeparator", { link = "PeacockFg" })
      nvim_set_hl(0, "FloatBorder", { link = "PeacockFg" })
      nvim_set_hl(0, "LineNr", { link = "PeacockFg" })
      nvim_set_hl(0, "lualine_a_normal", { link = "PeacockBg" }) -- or use fg if needed
      nvim_set_hl(0, "lualine_b_normal", { link = "PeacockFg" }) -- or use fg if needed
      vim.schedule(function()
        nvim_set_hl(
          0,
          "lualine_transitional_lualine_a_normal_to_StatusLine",
          { link = "PeacockFg" }
        ) -- or use fg if needed
      end)
    end,
  },
  dev = true,
}

M[#M + 1] = {
  "brenoprata10/nvim-highlight-colors",
  opts = {
    ---Render style
    ---@usage 'background'|'foreground'|'virtual'
    render = "virtual",
    ---Set virtual symbol (requires render to be set to 'virtual')
    virtual_symbol = "■",
    virtual_symbol_prefix = "",
    virtual_symbol_suffix = " ",
    virtual_symbol_position = "inline",
    ---Highlight tailwind colors, e.g. 'bg-blue-500'
    enable_tailwind = true,
  },
}
M[#M + 1] = {
  "nvim-tree/nvim-web-devicons",
}

M[#M + 1] = {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-web-devicons" },
  opts = {
    options = {
      theme = "dracula-nvim",
      extensions = { "quickfix" },
      component_separators = "  ",
      globalstatus = true,
      disabled_filetypes = {
        winbar = { "neo-tree", "terminal", "toggleterm" },
      },
    },
    sections = {
      lualine_a = {
        {
          "mode",
          separator = { left = "█" },
          right_padding = 2,
        },
      },
      lualine_b = {
        { "filename", icon = { "", align = "left" } },
        "branch",
      },
      lualine_c = {
        "lsp_progress",
        {
          function()
            local reg = vim.fn.reg_recording()
            return reg ~= "" and ("  @" .. reg) or ""
          end,
          color = { fg = "#ff9e64" },
        },
      },
      lualine_x = {},
      lualine_y = { "filetype", "progress" },
      lualine_z = {
        { "location", separator = { right = "" }, left_padding = 2 },
      },
    },
  },
}

return M

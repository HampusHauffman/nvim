---@type LazyPluginSpec[]
local M = {}
M[#M + 1] = { "arkav/lualine-lsp-progress" }

M[#M + 1] = {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "codecompanion" },
}

M[#M + 1] = {
  "hampushauffman/peacock.nvim",
  --dir = "~/Documents/peacock.nvim",
  --dev = true,
  name = "peacock",
  enabled = false,
  lazy = false,
  priority = 999, -- After (1000: Colorscheme)
  dependencies = { "nvim-lualine/lualine.nvim" },
  config = function()
    ---@type PeacockOptions
    require("peacock").setup({
      --sign_column_width = 1,
      bar_enabled = false,
      --eob_enabled = false,
      colors = {
        "#FDC38E",
        "#E1837F",
        "#97EDA2",
        "#F6F6B6",
        "#D0B5F3",
        "#E7A1D7",
        "#BCF4F5",
        "#FFFFFF",
      },
    })

    -- Now that the plugin is set up and highlights exist, you can link or override them:
    local set = vim.api.nvim_set_hl
    set(0, "WinSeparator", { link = "PeacockFg" })
    set(0, "FloatBorder", { link = "PeacockFg" })
    set(0, "LineNr", { link = "PeacockFg" })
    set(0, "lualine_a_normal", { link = "PeacockBg" })
    --set(0, "lualine_b_normal", { link = "PeacockFg" })
    -- Link common UI groups used by snacks to Peacock highlights
    set(0, "FloatBorder", { link = "PeacockFg" })
    set(0, "FloatTitle", { link = "PeacockFg" })
    set(0, "Directory", { link = "PeacockFg" })
    -- BlinkCMP
    set(0, "BlinkCmpMenuBorder", { link = "PeacockFg" })
    set(0, "BlinkCmpDocBorder", { link = "PeacockFg" })
    set(0, "BlinkCmpSignatureHelpBorder", { link = "PeacockFg" })
  end,
}

M[#M + 1] = {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPost", "BufNewFile" },
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
  "folke/noice.nvim",
  event = "VeryLazy",
  ---@type NoiceConfig
  opts = {
    lsp = {
      hover = { enabled = false },
      signature = { enabled = false },
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
}

M[#M + 1] = {
  "nvim-lualine/lualine.nvim",
  event = { "VeryLazy" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      --theme = "dracula-nvim",
      extensions = { "quickfix" },
      --component_separators = "  ",
      globalstatus = true,
      disabled_filetypes = {
        winbar = { "neo-tree", "terminal", "toggleterm" },
      },
    },
    sections = {
      lualine_a = {
        {
          "mode",
          separator = { left = "" },
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
        { "location", separator = {}, left_padding = 2 },
      },
    },
  },
}

return M

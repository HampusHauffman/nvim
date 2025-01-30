---@type LazyPluginSpec[]
local M = {}
M[#M + 1] = { "arkav/lualine-lsp-progress" }

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
      lualine_c = {
        "lsp_progress",
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

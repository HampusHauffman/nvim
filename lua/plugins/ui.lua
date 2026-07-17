local M = {}

function M.setup()
  require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true,
    float = {
      transparent = true,
    },
    lsp_styles = {
      underlines = {
        errors = { "undercurl" },
        hints = { "undercurl" },
        warnings = { "undercurl" },
        information = { "undercurl" },
      },
    },
    color_overrides = {
      all = {
        base = "#000000",
        mantle = "#000000",
        crust = "#000000",
      },
    },
    integrations = {
      grug_far = true,
      mason = true,
      snacks = true,
      which_key = true,
    },
  })

  require("block").setup({
    automatic = false,
    priority = 1000,
    padding = 4,
  })

  require("nvim-highlight-colors").setup({
    enable_tailwind = true,
  })

  require("treesitter-context").setup({})

  require("lualine").setup({
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
  })
end

return M

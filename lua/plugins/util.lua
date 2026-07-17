local M = {}

function M.setup()
  require("lazydev").setup({
    library = {
      { path = "luvit-meta/library", words = { "vim%.uv" } },
      { path = "snacks.nvim" },
      { path = "flash.nvim" },
      { path = "catppuccin" },
      { path = "nvim-dap" },
    },
  })

  require("grug-far").setup({})

  require("snacks").setup({
    explorer = {
      replace_netrw = true,
      auto_close = true,
    },
    input = {
      enabled = true,
    },
    picker = {
      ui_select = true,
    },
    zen = {
      win = { backdrop = { transparent = false, blend = 99 } },
      on_open = function()
        require("mini.diff").disable(0)
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
      end,
      on_close = function()
        require("mini.diff").enable(0)
        vim.opt_local.number = true
        vim.opt_local.relativenumber = true
      end,
    },
    indent = { enabled = true },
    chunk = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    words = { enabled = true },
  })
end

return M

local M = {}

function M.init()
  vim.g.rustaceanvim = {
    tools = {
      float_win_config = {
        border = "rounded",
      },
    },
  }

  vim.g.db_ui_use_nerd_fonts = 1
end

function M.setup()
  require("mason").setup({
    ui = { border = "rounded" },
  })

  require("mason-lspconfig").setup({
    ensure_installed = {
      "copilot",
      "jdtls",
      "lua_ls",
      "rust_analyzer",
      "ts_ls",
    },
    automatic_enable = { exclude = { "jdtls", "rust_analyzer" } },
  })

  vim.lsp.enable("gdscript")

  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettierd", stop_after_first = true },
      typescript = { "prettierd", stop_after_first = true },
      typescriptreact = { "prettierd", stop_after_first = true },
      gdscript = { "gdformat" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
  })
  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

  require("lint").linters_by_ft = {
    gdscript = { "gdlint" },
  }
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.gd",
    group = vim.api.nvim_create_augroup("gdscript_lint", { clear = true }),
    callback = function()
      require("lint").try_lint()
    end,
  })

  require("flutter-tools").setup({})

  local keymaps = require("keymaps")
  local lsp_keys = require("keymaps.lsp")
  keymaps.set(lsp_keys.keys)
  keymaps.set(lsp_keys.format_keys)
end

return M

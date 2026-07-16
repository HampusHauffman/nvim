---@type LazyPluginSpec[]
local M = {}

M[#M + 1] = {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = { ui = { border = "rounded" } } },
    "neovim/nvim-lspconfig",
  },
  opts = {
    ensure_installed = {
      "copilot",
      "jdtls",
      "lua_ls",
      "rust_analyzer",
      "ts_ls",
    },
    automatic_enable = { exclude = { "jdtls", "rust_analyzer" } },
  },
  cmd = "Mason",
  event = { "BufReadPre", "BufNewFile" },
  keys = require("keymaps.lsp").keys,
  config = function(_, opts)
    require("mason-lspconfig").setup(opts)
    vim.lsp.enable("gdscript")
  end,
}

M[#M + 1] = {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = require("keymaps.lsp").format_keys,
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
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
    format_on_save = { timeout_ms = 500 },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}

M[#M + 1] = {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("lint").linters_by_ft = {
      gdscript = { "gdlint" },
    }

    -- Lint GDScript files after writing them.
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*.gd",
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}

M[#M + 1] = {
  "mrcjkb/rustaceanvim",
  ft = "rust",
  init = function()
    vim.g.rustaceanvim = {
      tools = {
        float_win_config = {
          border = "rounded",
        },
      },
    }
  end,
}

M[#M + 1] = {
  "nvim-flutter/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
  },
  config = true,
}

M[#M + 1] = {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    {
      "kristijanhusak/vim-dadbod-completion",
      ft = { "sql", "mysql", "plsql" },
    },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}

return M

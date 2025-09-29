---@type LazyPluginSpec[]
local M = {}

M[#M + 1] = {
  "mason-org/mason-lspconfig.nvim",
  opts = {},
  keys = require("keymaps.lsp").keys,
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
  config = function(_, opts)
    require("mason-lspconfig").setup(opts)
    -- Enable custom gdscript LSP server
    vim.lsp.enable("gdscript")
  end,
}

M[#M + 1] = {
  "stevearc/conform.nvim",
  dependencies = { "mason-org/mason.nvim" },
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = require("keymaps.lsp").format_keys,
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettierd", stop_after_first = true },
      typescriptreact = { "prettierd", stop_after_first = true },
      typescript = { "prettierd", stop_after_first = true },
      gdscript = { "gdformat", stop_after_first = false },
    },
    -- Set default options
    default_format_opts = {
      lsp_format = "fallback",
    },
    -- Set up format-on-save
    --format_on_save = { timeout_ms = 500 },
    -- Customize formatters
    formatters = {
      gdformat = {
        cmd = "gdformat",
      },
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}

-- Extra linting
M[#M + 1] = {
  "mfussenegger/nvim-lint",
  config = function()
    require("lint").linters_by_ft = {
      gdscript = { "gdlint" },
    }

    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*",
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}

M[#M + 1] = {
  "mrcjkb/rustaceanvim",
  ft = { "rust" },
  config = function()
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
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional for vim.ui.select
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
      lazy = true,
    }, -- Optional
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}

return M

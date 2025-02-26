---@type LazyPluginSpec[]
local M = {}

local border = {
  { "╭", "FloatBorder" }, -- Top-left corner
  { "─", "FloatBorder" }, -- Top border
  { "╮", "FloatBorder" }, -- Top-right corner
  { "│", "FloatBorder" }, -- Right border
  { "╯", "FloatBorder" }, -- Bottom-right corner
  { "─", "FloatBorder" }, -- Bottom border
  { "╰", "FloatBorder" }, -- Bottom-left corner
  { "│", "FloatBorder" }, -- Left border
}

---@type LazyKeysSpec[]
local lspKeys = {
  { "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
  { "gi", vim.lsp.buf.implementation, desc = "Go to implementation" },
  {
    "gr",
    function()
      Snacks.picker.lsp_references()
    end,
    desc = "Go to references",
  },
  {
    "gd",
    function()
      Snacks.picker.lsp_definitions()
    end,
    desc = "Go to definition",
  },
  { "K", vim.lsp.buf.hover, desc = "Hover documentation" },
  { "<leader>r", vim.lsp.buf.rename, desc = "Rename symbol" },
  { "<leader>c", vim.lsp.buf.code_action, desc = "Code action" },
  { "<c-p>", vim.diagnostic.goto_prev, desc = "Go to previous diagnostic" },
  { "<c-n>", vim.diagnostic.goto_next, desc = "Go to next diagnostic" },
  { "<c-b>", vim.diagnostic.open_float, desc = "Go to next diagnostic" },
}

M[#M + 1] = {
  "williamboman/mason.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "saghen/blink.cmp",
  },
  keys = lspKeys,
  lazy = false,
  ---@param opts MasonSettings | {ensure_installed: string[]}
  config = function(_, opts)
    -- Borders rounded for hover and signature help
    local handlers = {
      ["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = border }
      ),
      ["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = border }
      ),
    }

    local capabilities = require("blink.cmp").get_lsp_capabilities()
    local lspSetup = { capabilities = capabilities, handlers = handlers }

    require("mason").setup({ ui = { border = "rounded" } })
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "ts_ls", "eslint", "tailwindcss" },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup(lspSetup)
        end,
        ["rust_analyzer"] = function() end,
      },
    })

    -- Remaining configs for lsp
    require("lspconfig").gdscript.setup(lspSetup)
  end,
}

M[#M + 1] = {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>f",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
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

-- Extra linting for GDScript
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
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional for vim.ui.select
  },
  config = true,
}

M[#M + 1] = {
  "saecki/crates.nvim",
  tag = "stable",
  config = function()
    require("crates").setup({})
  end,
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

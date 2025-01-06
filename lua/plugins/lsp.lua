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
      require("fzf-lua").lsp_references({
        fname_width = 1000,
        show_line = false,
      })
    end,
    desc = "Go to references",
  },
  {
    "gd",
    function()
      require("fzf-lua").lsp_definitions({})
    end,
    desc = "Go to definition",
  },
  { "K", vim.lsp.buf.hover, desc = "Hover documentation" },
  {
    "<leader>r",
    function()
      vim.lsp.buf.rename()
      vim.cmd("silent! wa")
    end,
    desc = "Rename symbol",
  },
  { "<leader>c", vim.lsp.buf.code_action, desc = "Code action" },
  { "<c-p>", vim.diagnostic.goto_prev, desc = "Go to previous diagnostic" },
  { "<c-n>", vim.diagnostic.goto_next, desc = "Go to next diagnostic" },
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
  config = function()
    require("mason").setup({
      ui = { border = "rounded" },
    })

    require("mason-lspconfig").setup({
      -- Install Stylua manually since there is no mapping
      ensure_installed = { "lua_ls", "ts_ls", "eslint", "tailwindcss" }, -- Specify the LSP servers to ensure are installed
    })

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
    -- List of servers to exclude
    local exclude_servers = { "rust_analyzer" }

    -- Setup server automatically. And set borders to rounded
    require("mason-lspconfig").setup_handlers({
      function(server_name)
        if not vim.tbl_contains(exclude_servers, server_name) then
          local capabilities = require("blink.cmp").get_lsp_capabilities()
          require("lspconfig")[server_name].setup({
            handlers = handlers,
            capabilities = capabilities,
          })
        end
      end,
    })
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
    },
    -- Set default options
    default_format_opts = {
      lsp_format = "fallback",
    },
    -- Set up format-on-save
    format_on_save = { timeout_ms = 500 },
    -- Customize formatters
    formatters = {
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
  "saecki/crates.nvim",
  tag = "stable",
  config = function()
    require("crates").setup({})
  end,
}

return M

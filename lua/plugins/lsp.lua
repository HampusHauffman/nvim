---@type LazyPluginSpec[]
local M = {}

local border = {
  { "╭", "FloatBorder" }, -- Top-left corner
  { "─", "FloatBorder" }, -- Top border
  { "╮", "FloatBorder" }, -- Top-right corner
  { "│", "FloatBorder" }, -- Right border { "╯", "FloatBorder" }, -- Bottom-right corner { "─", "FloatBorder" }, -- Bottom border
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
      require("telescope.builtin").lsp_references({
        fname_width = 1000,
        show_line = false,
      })
    end,
    desc = "Go to references",
  },
  {
    "gd",
    function()
      require("telescope.builtin").lsp_definitions({})
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
    "telescope.nvim",
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
  },
  keys = lspKeys,
  config = function()
    require("mason").setup({
      ui = { border = "rounded" },
    })

    require("mason-lspconfig").setup({
      -- Install Stylua manually since there is no mapping
      ensure_installed = { "lua_ls" }, -- Specify the LSP servers to ensure are installed
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
    -- Setup server automatically. And set borders to rounded
    require("mason-lspconfig").setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({ handlers = handlers })
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
      python = { "isort", "black" },
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

return M

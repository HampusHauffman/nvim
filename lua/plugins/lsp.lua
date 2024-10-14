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
  {
    "<leader>f",
    function()
      vim.lsp.buf.format({})
    end,
    desc = "Format buffer",
  },
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
  { "<f14>", vim.diagnostic.goto_prev, desc = "Go to previous diagnostic" },
  { "<f2>", vim.diagnostic.goto_next, desc = "Go to next diagnostic" },
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
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
    }
    -- Setup server automatically. And set borders to rounded
    require("mason-lspconfig").setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({ handlers = handlers })
      end,
    })
  end,
}

-- Used for tools that are not integrated with a LSP
M[#M + 1] = {
  "nvimtools/none-ls.nvim",
  dependencies = { "mason.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({ sources = { null_ls.builtins.formatting.stylua } })
  end,
}

-- This is only used to make sure i can specify ensure installed for tools
M[#M + 1] = {
  "jay-babu/mason-null-ls.nvim",
  dependencies = { "mason.nvim", "none-ls.nvim" },
  config = function()
    require("mason-null-ls").setup({
      -- All sources in null-ls will be automatic_installation
      ensure_installed = {},
      automatic_installation = true,
    })
  end,
}

return M

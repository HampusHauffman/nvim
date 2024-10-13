---@type LazyPluginSpec[]
local M = {}

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
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
  },
  keys = lspKeys,
  config = function()
    require("mason").setup()

    require("mason-lspconfig").setup({
      -- Install Stylua manually since there is no mapping
      ensure_installed = { "lua_ls" }, -- Specify the LSP servers to ensure are installed
    })

    require("mason-lspconfig").setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({})
      end,
    })
  end,
}

M[#M + 1] = {
  "nvimtools/none-ls.nvim",
  dependencies = { "mason.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({ sources = { null_ls.builtins.formatting.stylua } })
  end,
}

return M

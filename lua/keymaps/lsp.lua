local M = {}

--- Keys for lsp interactions
---@type LazyKeysSpec[]
M.keys = {
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
  {
    "<leader><s-r>",
    function()
      Snacks.rename.rename_file()
    end,
    desc = "Rename file",
  },
  {
    "K",
    function()
      vim.lsp.buf.hover({ border = "rounded" })
    end,
    desc = "Hover documentation",
  },
  { "<leader>r", vim.lsp.buf.rename, desc = "Rename symbol" },
  { "<leader>c", vim.lsp.buf.code_action, desc = "Code action" },
  {
    "<c-p>",
    function()
      vim.diagnostic.jump({ count = -1, float = true })
    end,
    desc = "Go to previous diagnostic",
  },
  {
    "<c-n>",
    function()
      vim.diagnostic.jump({ count = 1, float = true })
    end,
    desc = "Go to next diagnostic",
  },
  { "<c-b>", vim.diagnostic.open_float, desc = "Open diagnostic float" },
}

---@type LazyKeysSpec[]
M.format_keys = {
  {
    "<leader>f",
    function()
      require("conform").format({ async = true })
    end,
    mode = "",
    desc = "Format buffer",
  },
}

return M

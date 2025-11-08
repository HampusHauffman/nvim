---@type vim.lsp.ClientConfig
return {
  name = "gdshader-lsp",
  cmd = { "/Users/hampus/Documents/gdshader-lsp/target/debug/gdshader-lsp" },
  filetypes = { "gdshader" },
  capabilities = vim.lsp.protocol.make_client_capabilities(),
}

    ---@type vim.lsp.ClientConfig
    return {
      name = "gdshader",
      cmd = { "node", vim.fn.expand("~/Documents/gdshader-lsp/client/bridge.js") },
      --cmd = { "node", "/Users/hampus/Documents/gdshader-lsp/client/bridge.js" },
      filetypes = { "gdshader" },
      root_dir = vim.fs.dirname(vim.fs.find({'project.godot', '.git'}, { upward = true })[1]),
      capabilities = vim.lsp.protocol.make_client_capabilities(),
      on_attach = function(client, bufnr)
        print("HELLO")
      end
    }

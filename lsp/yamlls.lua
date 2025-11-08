---@type vim.lsp.ClientConfig
return {
  settings = {
    yaml = {
      schemaStore = {
        enable = true,
      },
      schemas = {
        ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.33.0-standalone-strict/all.json"] = "**/k8s/**/*.y{a,}ml",
      },
      validate = true,
      format = {
        enable = true,
      },
      hover = true,
      completion = true,
    },
  },
}

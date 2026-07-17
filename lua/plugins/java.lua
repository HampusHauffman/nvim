local M = {}

function M.setup()
  local jdtls = require("jdtls")
  local root_markers = {
    "gradlew",
    "mvnw",
    "settings.gradle",
    "build.gradle",
    "pom.xml",
    ".git",
  }

  local function start(bufnr)
    local root_dir = vim.fs.root(bufnr, root_markers)
    if not root_dir then
      return
    end

    local workspace_dir = vim.fn.stdpath("cache")
      .. "/jdtls/workspace/"
      .. vim.fs.basename(root_dir)

    ---@type vim.lsp.ClientConfig
    local config = {
      name = "jdtls",
      cmd = {
        vim.fn.stdpath("data") .. "/mason/bin/jdtls",
        "-data",
        workspace_dir,
      },
      root_dir = root_dir,
      capabilities = require("blink.cmp").get_lsp_capabilities(),
      init_options = { bundles = {} },
    }

    jdtls.start_or_attach(config)
  end

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    group = vim.api.nvim_create_augroup("jdtls_attach", { clear = true }),
    callback = function(args)
      start(args.buf)
    end,
  })

  if vim.bo.filetype == "java" then
    start(vim.api.nvim_get_current_buf())
  end
end

return M

---@type LazyPluginSpec[]
local M = {}

-- jdtls is installed via mason (see plugins/lsp.lua `ensure_installed`) and is
-- excluded from mason-lspconfig's `automatic_enable`, so nvim-jdtls is the only
-- thing that starts it. This avoids a double-start / workspace-lock conflict.
M[#M + 1] = {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  dependencies = { "mason-org/mason.nvim" },
  config = function()
    local jdtls = require("jdtls")
    local mason_jdtls = vim.fn.stdpath("data") .. "/mason/bin/jdtls"
    local root_markers = {
      "gradlew",
      "mvnw",
      "settings.gradle",
      "build.gradle",
      "pom.xml",
      ".git",
    }

    ---@param bufnr integer
    local function start(bufnr)
      local root_dir = vim.fs.root(bufnr, root_markers)
      if not root_dir then
        return
      end

      -- A stable, per-project data directory so jdtls doesn't re-index on
      -- every launch.
      local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
      local workspace_dir = vim.fn.stdpath("cache")
        .. "/jdtls/workspace/"
        .. project_name

      ---@type vim.lsp.ClientConfig
      local config = {
        name = "jdtls",
        cmd = { mason_jdtls, "-data", workspace_dir },
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

    -- The FileType event that lazy-loaded this plugin has already fired, so
    -- start jdtls for the buffer that triggered it.
    start(vim.api.nvim_get_current_buf())
  end,
}

return M

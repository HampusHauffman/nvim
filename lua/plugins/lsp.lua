---@type LazyPluginSpec[]
local M = {}

M[#M + 1] = {
  "mason-org/mason.nvim",
  dependencies = {
    "nvim-lspconfig",
    "mason-lspconfig.nvim",
    "blink.cmp",
  },
  keys = require("keymaps.lsp").keys,
  lazy = false,
  ---@param opts MasonSettings | {ensure_installed: string[]}
  config = function(_, opts)
    -- Borders rounded for hover and signature help

    local capabilities = require("blink.cmp").get_lsp_capabilities()
    local lspSetup = { capabilities = capabilities }

    require("mason").setup({ ui = { border = "rounded" } })
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "ts_ls", "eslint", "tailwindcss" },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup(lspSetup)
        end,
        ["rust_analyzer"] = function() end,
      },
    })

    -- Remaining configs for lsp
    require("lspconfig").gdscript.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        -- Exec Path: /opt/homebrew/bin/nvim
        -- Exec Flags: --server {project}/server.pipe --remote-send "<C-\><C-N>:e {file}<CR>:call cursor({line}+1,{col})<CR>"
        -- Start server to listen to inputs from godot
        local pipe_path = vim.fn.getcwd() .. "/server.pipe"
        -- serverlist() returns a list of available server addresses
        if not vim.tbl_contains(vim.fn.serverlist(), pipe_path) then
          -- Start server to listen to inputs from Godot, only if not already started
          pcall(vim.fn.serverstart, pipe_path)
        end
      end,
    })
    --require("lspconfig").glsl_analyzer.setup({
    --  capabilities = capabilities,
    --  filetypes = { "gdshader" },
    --})
  end,
}

M[#M + 1] = {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = require("keymaps.lsp").format_keys,
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
      gdscript = { "gdformat", stop_after_first = false },
    },
    -- Set default options
    default_format_opts = {
      lsp_format = "fallback",
    },
    -- Set up format-on-save
    --format_on_save = { timeout_ms = 500 },
    -- Customize formatters
    formatters = {
      gdformat = {
        cmd = "gdformat",
      },
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

-- Extra linting
M[#M + 1] = {
  "mfussenegger/nvim-lint",
  config = function()
    require("lint").linters_by_ft = {
      gdscript = { "gdlint" },
    }

    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*",
      callback = function()
        require("lint").try_lint()
      end,
    })
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
  "nvim-flutter/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional for vim.ui.select
  },
  config = true,
}

M[#M + 1] = {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    {
      "kristijanhusak/vim-dadbod-completion",
      ft = { "sql", "mysql", "plsql" },
      lazy = true,
    }, -- Optional
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}

return M

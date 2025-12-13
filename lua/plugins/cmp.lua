---@type LazyPluginSpec[]
local M = {}
local cmp_keymaps = require("keymaps.cmp")

M[#M + 1] = {
  "saghen/blink.cmp",
  -- optional: provides snippets for the snippet source
  dependencies = {
    "rafamadriz/friendly-snippets",
    -- "giuxtaposition/blink-cmp-copilot",
    -- "fang2hou/blink-copilot",
  },

  event = { "VeryLazy", "InsertEnter", "CmdlineChanged" },
  -- use a release tag to download pre-built binaries
  version = "*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    cmdline = {
      enabled = true,
      sources = { "path", "cmdline" },
      keymap = cmp_keymaps.cmdline_keymap,
    },
    completion = {
      menu = {
        border = "rounded",
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            --{ "source_name" },
          },
        },
      },

      ghost_text = { enabled = false },
      documentation = { auto_show = true, window = { border = "rounded" } },
      -- Makes sure we dont auto select when in cmd mode
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
    },
    signature = { enabled = true, window = { border = "rounded" } },
    keymap = cmp_keymaps.keymap,

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = {
        -- "copilot",
        "lazydev",
        "lsp",
        "path",
        --"buffer",
        "codecompanion",
        --"minuet",
        "dadbod",
      },
      providers = {
        cmdline = {
          min_keyword_length = function(ctx)
            -- when typing a command, only show when the keyword is 4 characters or longer
            if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
              return 3
            end
            return 0
          end,
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        codecompanion = {
          name = "CodeCompanion",
          module = "codecompanion.providers.completion.blink",
        },
        -- copilot = {
        --   name = "copilot",
        --   module = "blink-copilot",
        --   score_offset = 100,
        --   async = true,
        -- },
      },
    },
  },
  opts_extend = { "sources.default" },
}

return M

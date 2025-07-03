---@type LazyPluginSpec[]
local M = {}
M[#M + 1] = {
  "saghen/blink.cmp",
  -- optional: provides snippets for the snippet source
  dependencies = {
    "rafamadriz/friendly-snippets",
    "giuxtaposition/blink-cmp-copilot",
  },

  -- use a release tag to download pre-built binaries
  version = "*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {

    cmdline = {
      enabled = true,
      completion = {
        menu = {
          auto_show = false,
        },
      },
      sources = { "path", "cmdline" },
      keymap = {
        preset = "none", -- Disable the preset to use only our custom mappings
        ["<C-j>"] = { "show_and_insert", "select_next", "fallback" },
        ["<C-k>"] = { "show_and_insert", "select_prev", "fallback" },
        ["<Tab>"] = { "show_and_insert", "select_next", "fallback" },
        ["<S-Tab>"] = { "show_and_insert", "select_prev", "fallback" },
        ["<C-space>"] = { "show_and_insert" },
      },
    },

    completion = {
      menu = {
        border = "rounded",
        draw = {
          columns = {

            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "source_name" },
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
    keymap = {
      preset = "none",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "snippet_forward", "fallback", "accept", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = {
        "lazydev",
        "lsp",
        "path",
        --"buffer",
        "codecompanion",
        "dadbod",
  ---"copilot",
      },
      providers = {
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

        --copilot = {
        --  name = "copilot",
        --  module = "blink-cmp-copilot",
        --  score_offset = 100,
        --  async = true,
        --},
      },
    },
  },
  opts_extend = { "sources.default" },
}

return M

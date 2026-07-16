local keymaps = require("keymaps.cmp")

---@type LazyPluginSpec[]
local M = {}

M[#M + 1] = {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  event = { "VeryLazy", "InsertEnter", "CmdlineChanged" },
  version = "*",
  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    cmdline = {
      enabled = true,
      sources = { "path", "cmdline" },
      keymap = keymaps.cmdline_keymap,
    },
    completion = {
      menu = {
        border = "rounded",
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
          },
        },
      },
      ghost_text = { enabled = false },
      documentation = {
        auto_show = true,
        window = { border = "rounded" },
      },
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
    },
    signature = {
      enabled = true,
      window = { border = "rounded" },
    },
    keymap = keymaps.keymap,
    sources = {
      default = { "lazydev", "lsp", "path", "dadbod" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        dadbod = {
          name = "Dadbod",
          module = "vim_dadbod_completion.blink",
        },
      },
    },
  },
  opts_extend = { "sources.default" },
}

return M

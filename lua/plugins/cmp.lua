---@diagnostic disable: missing-fields
---@type LazyPluginSpec[]
local M = {}

M[#M + 1] = {
  "hrsh7th/nvim-cmp",
  version = false, -- last release is way too old
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  ---@return cmp.Setup
  opts = function()
    local cmp = require("cmp")

    ---@type cmp.Setup
    return {
      window = {
        completion = cmp.config.window.bordered({
          winhighlight = "FloatBorder:FloatBorder,Normal:Normal",
        }),
        documentation = cmp.config.window.bordered({
          winhighlight = "FloatBorder:FloatBorder,Normal:Normal",
        }),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        -- Makes sure we can scroll with crtl j and k
        ["<C-j>"] = cmp.mapping(function(_)
          if cmp.visible() then
            cmp.select_next_item()
          end
        end, { "i", "s" }),

        ["<C-k>"] = cmp.mapping(function(_)
          if cmp.visible() then
            cmp.select_prev_item()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        --        { name = "copilot" },
        { name = "nvim_lsp" },
      }, {
        { name = "buffer" },
      }),
    }
  end,
}

M[#M + 1] = {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    table.insert(opts.sources, { name = "lazydev", group_index = 0 })
  end,
}
return M

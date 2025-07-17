local M = {}

---@type LazyKeysSpec[]
M.keys = {
  {
    "<leader><S-a>",
    "<cmd>CodeCompanionActions<cr>",
    mode = { "n", "v" },
    noremap = true,
    silent = true,
    desc = "Code Companion Actions",
  },
  {
    "<leader>a",
    "<cmd>CodeCompanionChat Toggle<cr>",
    mode = { "n", "v" },
    noremap = true,
    silent = true,
    desc = "Toggle Code Companion Chat",
  },
  {
    "ga",
    "<cmd>CodeCompanionChat Add<cr>",
    mode = "v",
    noremap = true,
    silent = true,
    desc = "Add selection to Code Companion Chat",
  },
  {
    "<leader>ac",
    function()
      require("minuet").complete()
    end,
    noremap = true,
    silent = true,
    desc = "Minuet Complete",
  },
  {
    "<leader>ad",
    function()
      require("minuet").dismiss()
    end,
    noremap = true,
    silent = true,
    desc = "Minuet Dismiss",
  },
}

return M

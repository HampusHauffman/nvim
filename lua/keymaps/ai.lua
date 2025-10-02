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
}

return M

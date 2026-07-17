local M = {}

---@type KeymapSpec[]
M.keys = {
  {
    "<leader>gB",
    function()
      Snacks.gitbrowse()
    end,
    desc = "Git Browse",
  },
  {
    "<leader>gb",
    function()
      Snacks.git.blame_line()
    end,
    desc = "Git Blame Line",
  },
  {
    "<leader>gd",
    "<cmd>CodeDiff<cr>",
    desc = "Git Diff",
  },
  {
    "<leader>gD",
    function()
      vim.api.nvim_feedkeys(":CodeDiff ", "n", false)
    end,
    desc = "Git Diff Revision",
  },
  {
    "<leader>gg",
    function()
      require("neogit").open()
    end,
    desc = "Neogit",
  },
  {
    "<leader>gh",
    "<cmd>CodeDiff history<cr>",
    desc = "Git History",
  },
}

---@type KeymapSpec[]
M.diff = {
  {
    "<leader>gr",
    function()
      return require("mini.diff").operator("reset") .. "gh"
    end,
    expr = true,
    remap = true,
    desc = "Reset hunk",
  },
  {
    "<leader>gr",
    function()
      local cursor = vim.fn.line(".")
      local anchor = vim.fn.line("v")
      require("mini.diff").do_hunks(0, "reset", {
        line_start = math.min(cursor, anchor),
        line_end = math.max(cursor, anchor),
      })
    end,
    mode = "x",
    desc = "Reset selected hunks",
  },
  {
    "<leader>go",
    function()
      require("mini.diff").toggle_overlay(0)
    end,
    desc = "Toggle mini.diff overlay",
  },
}

return M

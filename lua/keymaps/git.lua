local M = {}

---@type LazyKeysSpec[]
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
    "<leader>gf",
    function()
      Snacks.lazygit.log_file()
    end,
    desc = "Lazygit Current File History",
  },
  {
    "<leader>gg",
    function()
      Snacks.lazygit()
    end,
    desc = "Lazygit",
  },
  {
    "<leader>gl",
    function()
      Snacks.lazygit.log()
    end,
    desc = "Lazygit Log (cwd)",
  },
}

-- Mini diff keys
---@type LazyKeysSpec[]
M.diff = {
  {
    "<leader>go",
    function()
      require("mini.diff").toggle_overlay(0)
    end,
    desc = "Toggle mini.diff overlay",
  },
  -- Apply hunk
  {
    "<leader>ga",
    function()
      require("mini.diff").apply_hunk()
    end,
    desc = "Apply hunk (Normal)",
    mode = "n",
  },
  {
    "ga",
    function()
      require("mini.diff").apply_hunk()
    end,
    desc = "Apply hunk (Visual)",
    mode = "v",
  },
  -- Reset hunk
  {
    "<leader>gr",
    function()
      require("mini.diff").reset_hunk()
    end,
    desc = "Reset hunk (Normal)",
    mode = "n",
  },
  {
    "gr",
    function()
      require("mini.diff").reset_hunk()
    end,
    desc = "Reset hunk (Visual)",
    mode = "v",
  },
  -- Navigation
  {
    "<leader>gp",
    function()
      require("mini.diff").goto_hunk("prev")
    end,
    desc = "Goto previous hunk",
  },
  {
    "<leader>gn",
    function()
      require("mini.diff").goto_hunk("next")
    end,
    desc = "Goto next hunk",
  },
}

return M

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

-- This key is handled by lazy.nvim directly
---@type LazyKeysSpec[]
M.diff = {
  {
    "<leader>go",
    function()
      require("mini.diff").toggle_overlay(0)
    end,
    desc = "Toggle mini.diff overlay",
  },
}

-- These are not keymaps, but settings for mini.diff's setup function
M.diff_mappings = {
  apply = "<leader>ga",
  reset = "<leader>gr",
  textobject = "gh",
  goto_prev = "<leader>gp",
  goto_next = "<leader>gn",
}

return M

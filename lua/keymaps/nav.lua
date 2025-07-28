local M = {}

--- Keys for navigation and other plugins
---@type LazyKeysSpec[]
M.keys = {
  {
    "<leader>:",
    function()
      Snacks.picker.command_history()
    end,
    desc = "Command history",
  },
  {
    "ff",
    function()
      Snacks.picker.files()
    end,
    desc = "Find files",
    mode = "n",
  },
  {
    "fa",
    function()
      Snacks.picker.lsp_symbols()
    end,
    desc = "Document symbols",
  },
  {
    "fg",
    function()
      Snacks.picker.grep({ })
    end,
    desc = "Find grep",
  },
  {
    "fw",
    function()
      Snacks.picker.grep_word()
    end,
    desc = "Find word",
  },
  {
    "fo",
    function()
      Snacks.picker.files()
    end,
    desc = "Find files",
  },
  {
    "<leader>e",
    function()
      Snacks.picker.recent({ filter = { cwd = true } })
    end,
    desc = "Previous files",
  },
  {
    "fb",
    function()
      Snacks.picker.buffers()
    end,
    desc = "Find buffers",
  },
  {
    "fh",
    function()
      Snacks.picker.help()
    end,
    desc = "Find help tags",
  },
  {
    "zen",
    function()
      Snacks.zen()
    end,
    desc = "Zen",
  },
  {
    "<leader>m",
    function()
      Snacks.notifier.show_history()
    end,
    desc = "Show Notifier History",
  },
  {
    "<leader>n",
    function()
      local explorer_pickers = Snacks.picker.get({ source = "explorer" })
      for _, v in pairs(explorer_pickers) do
        if v:is_focused() then
          v:close()
        else
          v:focus()
        end
      end
      if #explorer_pickers == 0 then
        Snacks.picker.explorer({
          hidden = true,
          exclude = { "*.gd.uid", "*.import", "*.tres" },
        })
      end
    end,
    desc = "Toggle explorer",
  },
}

-- Tmux navigation keys
M.tmux = {
  { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
  { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
  { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
  { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
  { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
}

-- Flash navigation keys
M.flash = {
  { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
  { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
}

-- WhichKey navigation
M.which_key = {
  {
    "<leader>?",
    function()
      require("which-key").show({ global = false })
    end,
    desc = "Buffer Local Keymaps (which-key)",
  },
}

return M

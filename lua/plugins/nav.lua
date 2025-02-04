---@type LazyPluginSpec[]
local M = {}

---@type LazyKeysSpec[]
local fzfKeys = {
  {
    "ff",
    function()
      require("fzf-lua").files()
    end,
    desc = "Find files",
    mode = "n",
  },
  {
    "fa",
    function()
      require("fzf-lua").lsp_document_symbols()
    end,
    desc = "Document symbols",
  },
  {
    "fg",
    function()
      require("fzf-lua").live_grep()
    end,
    desc = "Find grep",
  },
  {
    "fo",
    function()
      require("fzf-lua").files()
    end,
    desc = "Find files",
  },
  {
    "<leader>e",
    function()
      require("fzf-lua").oldfiles({ cwd_only = true })
    end,
    desc = "Previous files",
  },
  {
    "fb",
    function()
      require("fzf-lua").buffers()
    end,
    desc = "Find buffers",
  },
  {
    "fh",
    function()
      require("fzf-lua").help_tags()
    end,
    desc = "Find help tags",
  },
}

M[#M + 1] = {
  "ibhagwan/fzf-lua",
  keys = fzfKeys,
  config = function(_, opts)
    require("fzf-lua").setup(opts)
    vim.cmd([[FzfLua register_ui_select]])
  end,

  opts = {
    oldfiles = {
      include_current_session = true, -- include bufs from current session
    },
    winopts = {
      width = 0.8,
      height = 0.8,
      row = 0.5,
      col = 0.5,
      preview = {
        scrollchars = { "┃", "" },
      },
    },
    fzf_opts = {
      ["--no-scrollbar"] = true,
    },
    keymap = {
      fzf = {
        ["ctrl-q"] = "select-all+accept",
        ["ctrl-u"] = "half-page-up",
        ["ctrl-d"] = "half-page-down",
        ["ctrl-x"] = "jump",
        ["ctrl-f"] = "preview-page-down",
        ["ctrl-b"] = "preview-page-up",
      },
      builtin = {
        ["<c-f>"] = "preview-page-down",
        ["<c-b>"] = "preview-page-up",
      },
    },
  },
}

M[#M + 1] = {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
}

M[#M + 1] = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    --{ "<leader><s-n>", ":Neotree left focus reveal<CR>", "File explorer" },
    --{ "<leader>n", ":Neotree left focus reveal<CR>", "File explorer" },
    {
      "<leader>n",
      function()
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname:match("neo%-tree") then
          vim.cmd("Neotree close")
        else
          vim.cmd("Neotree left focus reveal")
        end
      end,
      "File explorer",
    },
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
      },
    },
    popup_border_style = "rounded",
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    default_component_configs = {
      modified = { symbol = "" },
    },
  },
}

M[#M + 1] = {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    modes = {
      char = { enabled = false }, -- Disables default keys (F, f, T, t) so i can use S
    },
  },
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}

return M

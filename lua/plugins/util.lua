---@type LazyPluginSpec[]
local M = {}

-- Manage libuv types with lazy. Plugin will never be loaded
M[#M + 1] = { "Bilal2453/luvit-meta", lazy = true }

M[#M + 1] = {
  "folke/lazydev.nvim",
  ft = "lua",
  cmd = "LazyDev",
  opts = {
    library = {
      { path = "luvit-meta/library", words = { "vim%.uv" } },
      { path = "lazy.nvim" },
      { path = "snacks.nvim" },
    },
  },
}

--M[#M + 1] = { "echasnovski/mini.pairs", version = "*", opts = {} }

M[#M + 1] = {
  "MagicDuck/grug-far.nvim",
  config = function()
    require("grug-far").setup({})
  end,
}

---@type LazyKeysSpec[]
local navKeys = {
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
      Snacks.picker.grep()
    end,
    desc = "Find grep",
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
    "<s-z>",
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
        --if Snacks.zen.win.backdrop.closed == false then
        --  Snacks.picker.explorer({
        --    auto_close = true,
        --    layout = { layout = { position = "float" } },
        --  })
        --else
        --  Snacks.picker.explorer({})
        --end
        Snacks.picker.explorer({ hidden = true, exclude = {"*.gd.uid", "*.import", "*.tres"} })
      end
    end,
  },
}

M[#M + 1] = { "tpope/vim-sleuth" }

M[#M + 1] = {
  "folke/snacks.nvim",
  priority = 1000,
  keys = navKeys,
  lazy = false,
  ---@type snacks.Config
  opts = {
    explorer = {
      replace_netrw = true, -- Replace netrw with the snacks explorer
    },
    input = {
      enabled = true,
      win = { style = "input" },
    },
    picker = { ui_select = true },
    zen = {
      toggles = {
        dim = false,
      },
    },
    indent = { enabled = true },
    scope = { enabled = true },

    scroll = { enabled = true },
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░  ░░░░  ░░░      ░░░  ░░░░  ░░       ░░░  ░░░░  ░░░      ░░
▒  ▒▒▒▒  ▒▒  ▒▒▒▒  ▒▒   ▒▒   ▒▒  ▒▒▒▒  ▒▒  ▒▒▒▒  ▒▒  ▒▒▒▒▒▒▒
▓        ▓▓  ▓▓▓▓  ▓▓        ▓▓       ▓▓▓  ▓▓▓▓  ▓▓▓      ▓▓
█  ████  ██        ██  █  █  ██  ████████  ████  ████████  █
█  ████  ██  ████  ██  ████  ██  █████████      ████      ██
████████████████████████████████████████████████████████████

]],
      },
    },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      zen = {
        backdrop = { transparent = false, blend = 40 },
      },
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
  },
}

return M

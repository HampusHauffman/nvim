---@type LazyPluginSpec[]
local M = {
  { "nvim-telescope/telescope-ui-select.nvim" },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}

---@type LazyKeysSpec[]
local telescopeKeys = {
  {
    "ff",
    function()
      require("telescope.builtin").find_files()
    end,
    desc = "Find files",
    mode = "n",
  },
  {
    "fa",
    function()
      require("telescope.builtin").lsp_document_symbols({
        -- symbols = {}
      })
    end,
    desc = "Document symbols",
  },
  {
    "fg",
    function()
      require("telescope.builtin").live_grep()
    end,
    desc = "Find grep",
  },
  {
    "fo",
    function()
      require("telescope.builtin").find_files()
    end,
    desc = "Find files",
  },
  {
    "<leader>e",
    function()
      require("telescope.builtin").oldfiles({ only_cwd = true })
    end,
    desc = "Previous files",
  },
  {
    "fb",
    function()
      require("telescope.builtin").buffers()
    end,
    desc = "Find buffers",
  },
  {
    "fh",
    function()
      require("telescope.builtin").help_tags()
    end,
    desc = "Find help tags",
  },
}

M[#M + 1] = {
  "nvim-telescope/telescope.nvim",
  version = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = telescopeKeys,
  config = function(_, opts)
    require("telescope").setup(opts)
  end,
  opts = {
    defaults = {
      mappings = {
        n = {
          ["kj"] = "close",
          ["jk"] = "close",
        },
        i = {
          ["<S-Tab>"] = "move_selection_previous",
          ["<Tab>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
          ["<C-j>"] = "move_selection_next",
        },
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({
          -- even more opts
        }),
      },
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
    },
  },
}

return M

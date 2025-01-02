---@type LazyPluginSpec[]
---@type LazyPluginSpec[]
local M = {
  { "ibhagwan/fzf-lua" },
}

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
  end,
  opts = {
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

return M

local M = {}

local excludes = { "*.import", "*.tres", "*.uid", "*.tscn" }

local function picker(method, opts)
  return function()
    Snacks.picker[method](opts)
  end
end

local function flash(method)
  return function()
    require("flash")[method]()
  end
end

local function treesitter_select()
  require("flash").treesitter({
    actions = {
      ["<C-k>"] = "next",
      ["<C-j>"] = "prev",
    },
  })
end

---@type LazyKeysSpec[]
M.keys = {
  { "<leader>:", picker("command_history"), desc = "Command history" },
  { "ff", picker("files", { exclude = excludes }), desc = "Find files" },
  {
    "fa",
    picker("lsp_symbols", { layout = { preset = "sidebar" } }),
    desc = "Document symbols (sidebar)",
  },
  { "fg", picker("grep", { exclude = excludes }), desc = "Find grep" },
  { "fw", picker("grep_word"), desc = "Find word" },
  { "fo", picker("files"), desc = "Find files" },
  {
    "<leader>e",
    picker("recent", { filter = { cwd = true } }),
    desc = "Previous files",
  },
  { "fb", picker("buffers"), desc = "Find buffers" },
  { "fh", picker("help"), desc = "Find help tags" },
  { "<leader>m", picker("git_status"), desc = "Git changes" },

  {
    "<leader>§",
    function()
      Snacks.zen()
    end,
    desc = "Zen",
  },
  {
    "<leader>n",
    picker("explorer", {
      hidden = true,
      exclude = { "*.gd.uid", "*.import", "*.tres", "*.uid" },
    }),
    desc = "Files",
  },
}

M.tmux = {
  { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
  { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
  { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
  { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
  { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
}

M.flash = {
  {
    "<C-k>",
    treesitter_select,
    mode = "v",
    desc = "Treesitter increment selection",
  },
  {
    "<C-j>",
    treesitter_select,
    mode = "v",
    desc = "Treesitter decrement selection",
  },
  {
    "s",
    flash("jump"),
    mode = { "n", "x", "o" },
    desc = "Flash",
  },
  {
    "S",
    flash("treesitter"),
    mode = { "n", "x", "o" },
    desc = "Flash Treesitter",
  },
  { "r", flash("remote"), mode = "o", desc = "Remote Flash" },
  {
    "R",
    flash("treesitter_search"),
    mode = { "o", "x" },
    desc = "Treesitter Search",
  },
  {
    "<c-s>",
    flash("toggle"),
    mode = "c",
    desc = "Toggle Flash Search",
  },
}

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

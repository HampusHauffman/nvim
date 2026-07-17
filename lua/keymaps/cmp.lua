local M = {}

M.keymap = {
  preset = "none",
  ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
  ["<CR>"] = { "accept", "fallback" },
  ["<Tab>"] = { "accept", "select_next", "fallback" },
  ["<S-Tab>"] = { "select_prev", "fallback" },
  ["<Up>"] = { "select_prev", "fallback" },
  ["<Down>"] = { "select_next", "fallback" },
  ["<C-p>"] = { "select_prev", "fallback" },
  ["<C-n>"] = { "select_next", "fallback" },
  ["<C-k>"] = { "select_prev", "fallback" },
  ["<C-j>"] = { "select_next", "fallback" },
}

M.cmdline_keymap = {
  preset = "inherit",
  ["<Tab>"] = { "show_and_insert_or_accept_single", "select_next" },
  ["<S-Tab>"] = { "show_and_insert_or_accept_single", "select_prev" },
  ["<Down>"] = { "select_next", "fallback" },
  ["<Up>"] = { "select_prev", "fallback" },
  ["<CR>"] = { "fallback" },
  ["<C-space>"] = { "show", "fallback" },
  ["<C-j>"] = { "show_and_insert_or_accept_single", "select_next" },
  ["<C-k>"] = { "show_and_insert_or_accept_single", "select_prev" },
}

return M

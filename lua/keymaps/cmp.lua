local M = {}

M.keymap = {
  preset = "none",
  ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
  ["<CR>"] = { "accept", "fallback" },
  ["<Tab>"] = { "snippet_forward", "fallback", "accept", "fallback" },
  ["<S-Tab>"] = { "snippet_backward", "fallback" },
  ["<Up>"] = { "select_prev", "fallback" },
  ["<Down>"] = { "select_next", "fallback" },
  ["<C-p>"] = { "select_prev", "fallback" },
  ["<C-n>"] = { "select_next", "fallback" },
  ["<C-k>"] = { "select_prev", "fallback" },
  ["<C-j>"] = { "select_next", "fallback" },
}

M.cmdline_keymap = {
  preset = "inherit", -- Disable the preset to use only our custom mappings
  -- preset = "none", -- Disable the preset to use only our custom mappings
  -- ["<C-j>"] = { "show_and_insert_or_accept_single", "select_next", "fallback" },
  -- ["<C-k>"] = { "show_and_insert_or_accept_single", "select_prev", "fallback" },
  -- ["<Tab>"] = { "show_and_insert", "select_next", "fallback" },
  -- ["<S-Tab>"] = { "show_and_insert", "select_prev", "fallback" },
  -- ["<C-space>"] = { "show_and_insert" },
  -- ["<CR>"] = { "accept_and_enter", "fallback" },
  ["<Tab>"] = { "show_and_insert_or_accept_single", "select_next" },
  ["<S-Tab>"] = { "show_and_insert_or_accept_single", "select_prev" },

  ["<C-space>"] = { "show", "fallback" },

  ["<C-j>"] = { "select_next", "fallback" },
  ["<C-k>"] = { "select_prev", "fallback" },
}

return M

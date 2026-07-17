local M = {}

function M.setup()
  require("mini.diff").setup({
    mappings = {
      apply = "<leader>ga",
      reset = "<leader>gr",
      textobject = "gh",
      goto_prev = "<leader>gp",
      goto_next = "<leader>gn",
    },
    view = {
      style = "sign",
      signs = {
        add = "▎",
        change = "▎",
        delete = "_",
      },
    },
  })

  require("codediff").setup({})
  require("neogit").setup({
    integrations = {
      codediff = true,
      diffview = false,
      snacks = true,
    },
    diff_viewer = "codediff",
  })

  local keymaps = require("keymaps")
  local git = require("keymaps.git")
  keymaps.set(git.diff)
  keymaps.set(git.keys)
end

return M

local M = {}

function M.setup()
  require("mini.diff").setup({

    mappings = {
      apply = "",
      reset = "",
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

  require("codediff").setup({
    keymaps = {
      view = {
        next_hunk = "<leader>gn",
        prev_hunk = "<leader>gp",
        stage_hunk = "<leader>gs",
        unstage_hunk = "<leader>gu",
        discard_hunk = "<leader>gr",
      },
    },
  })
  require("neogit").setup({
    integrations = {
      codediff = true,
      diffview = false,
      snacks = true,
    },
    diff_viewer = "codediff",
    mappings = {
      status = {
        ["<leader>gn"] = "GoToNextHunkHeader",
        ["<leader>gp"] = "GoToPreviousHunkHeader",
        ["<leader>gs"] = "Stage",
        ["<leader>gu"] = "Unstage",
        ["<leader>gr"] = "Discard",
      },
    },
  })

  local keymaps = require("keymaps")
  local git = require("keymaps.git")
  keymaps.set(git.diff)
  keymaps.set(git.keys)
end

return M

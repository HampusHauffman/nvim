local M = {}

function M.setup()
  require("flash").setup({
    modes = {
      char = { enabled = false },
      treesitter = {
        labels = "",
      },
    },
  })

  local keymaps = require("keymaps")
  local nav = require("keymaps.nav")
  keymaps.set(nav.tmux)
  keymaps.set(nav.flash)
  keymaps.set(nav.keys)
end

return M

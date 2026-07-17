local M = {}

function M.setup()
  require("which-key").setup({
    win = { border = "rounded" },
    triggers = {
      { "<auto>", mode = "nixsotc" },
      { "<leader>", mode = { "n", "v" } },
      { "f", mode = { "n", "v" } },
      { "g", mode = { "n", "v" } },
    },
  })

  require("keymaps").set(require("keymaps.nav").which_key)
end

return M

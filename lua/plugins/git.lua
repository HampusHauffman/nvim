---@type LazyPluginSpec[]
local M = {}

M[#M + 1] = {
  "lewis6991/gitsigns.nvim",
  lazy = false,
  keys = {
    {
      "<leader>hs",
      function()
        require("gitsigns").stage_hunk()
      end,
      desc = "Stage hunk",
    },
    {
      "<leader>hr",
      function()
        require("gitsigns").reset_hunk()
      end,
      desc = "Reset hunk",
    },
    {
      "<leader>hS",
      function()
        require("gitsigns").stage_buffer()
      end,
      desc = "Stage buffer",
    },
    {
      "<leader>hu",
      function()
        require("gitsigns").undo_stage_hunk()
      end,
      desc = "Undo stage hunk",
    },
    {
      "<leader>hR",
      function()
        require("gitsigns").reset_buffer()
      end,
      desc = "Reset buffer",
    },
    {
      "<leader>hp",
      function()
        require("gitsigns").preview_hunk()
      end,
      desc = "Preview hunk",
    },
    {
      "<leader>hb",
      function()
        require("gitsigns").blame_line({ full = true })
      end,
      desc = "Blame line",
    },
    {
      "<leader>tb",
      function()
        require("gitsigns").toggle_current_line_blame()
      end,
      desc = "Toggle current line blame",
    },
    {
      "<leader>hd",
      function()
        require("gitsigns").diffthis()
      end,
      desc = "Diff",
    },
    {
      "<leader>hD",
      function()
        require("gitsigns").diffthis("~")
      end,
      desc = "Diff (cached)",
    },
    {
      "<leader>td",
      function()
        require("gitsigns").toggle_deleted()
      end,
      desc = "Toggle deleted",
    },
    {
      "<leader>hj",
      function()
        require("gitsigns").next_hunk()
      end,
      desc = "Toggle deleted",
    },
    {
      "<leader>hk",
      function()
        require("gitsigns").prev_hunk()
      end,
      desc = "Toggle deleted",
    },
  },
  opts = {},
}

return M

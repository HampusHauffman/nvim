local M = {}

local function github(repo)
  return "https://github.com/" .. repo
end

---@type vim.pack.Spec[]
local packages = {
  github("nvim-lua/plenary.nvim"),
  github("nvim-tree/nvim-web-devicons"),
  github("nvim-neotest/nvim-nio"),
  github("rafamadriz/friendly-snippets"),
  github("stevearc/dressing.nvim"),
  github("tpope/vim-dadbod"),
  github("mason-org/mason.nvim"),
  github("neovim/nvim-lspconfig"),
  { src = github("nvim-treesitter/nvim-treesitter"), version = "main" },
  { src = github("catppuccin/nvim"), name = "catppuccin" },
  github("folke/snacks.nvim"),
  github("Bilal2453/luvit-meta"),
  github("folke/lazydev.nvim"),
  github("MagicDuck/grug-far.nvim"),
  github("tpope/vim-sleuth"),
  github("christoomey/vim-tmux-navigator"),
  github("folke/flash.nvim"),
  github("MeanderingProgrammer/render-markdown.nvim"),
  github("brenoprata10/nvim-highlight-colors"),
  github("nvim-treesitter/nvim-treesitter-context"),
  github("nvim-lualine/lualine.nvim"),
  github("folke/which-key.nvim"),
  { src = github("saghen/blink.cmp"), version = vim.version.range("*") },
  github("mfussenegger/nvim-dap"),
  github("rcarriga/nvim-dap-ui"),
  github("theHamsta/nvim-dap-virtual-text"),
  github("mfussenegger/nvim-jdtls"),
  github("mason-org/mason-lspconfig.nvim"),
  github("stevearc/conform.nvim"),
  github("mfussenegger/nvim-lint"),
  github("mrcjkb/rustaceanvim"),
  github("nvim-flutter/flutter-tools.nvim"),
  github("kristijanhusak/vim-dadbod-completion"),
  github("kristijanhusak/vim-dadbod-ui"),
  github("echasnovski/mini.diff"),
  github("esmuellert/codediff.nvim"),
  github("NeogitOrg/neogit"),
}

function M.setup()
  local block_path = vim.fn.expand("~/Documents/block.nvim")
  assert(vim.uv.fs_stat(block_path), "block.nvim not found at " .. block_path)
  vim.opt.rtp:prepend(block_path)

  require("plugins.lsp").init()
  require("plugins.treesitter").init()

  vim.pack.add(packages, { confirm = false, load = true })

  require("plugins.util").setup()
  require("plugins.nav").setup()
  require("plugins.git").setup()
  require("plugins.cmp").setup()
  require("plugins.dap").setup()
  require("plugins.java").setup()
  require("plugins.lsp").setup()
  require("plugins.treesitter").setup()
  require("plugins.which-key").setup()
  require("plugins.ui").setup()

  vim.cmd.colorscheme("catppuccin-mocha")
end

return M

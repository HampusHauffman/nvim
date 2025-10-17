---@type LazyPluginSpec[]
local M = {}

M[#M + 1] = {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false, -- This plugin is not meant to be lazy-loaded
  config = function()
    require("nvim-treesitter").install({
      "lua",
      "vim",
      "vimdoc",
      "query",
      "markdown",
      "c",
    })

    vim.api.nvim_create_autocmd({ "FileType" }, {
      group = vim.api.nvim_create_augroup(
        "user_treesitter_auto_install_and_start",
        { clear = true }
      ),
      callback = function(event)
        vim.schedule(function()
          -- Get the FileType
          local filetype = event.match
          -- Get BufNr
          local bufnr = event.buf
          -- Get associated language or filetype as fallback
          local lang = vim.treesitter.language.get_lang(filetype)
          -- Install. This is a non-operation if already installed
          require("nvim-treesitter").install({ lang }):wait(120000)
          -- Attach parser if available
          local ok, _ = pcall(vim.treesitter.get_parser, bufnr, lang)
          -- Start parser for buf
          if ok then
            vim.treesitter.start(bufnr)
          end
        end)
      end,
    })
  end,
}

return M

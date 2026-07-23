local M = {}

local update_required = false
local parsers = {
  "lua",
  "vim",
  "vimdoc",
  "query",
  "markdown",
  "c",
  "gdscript",
}

function M.init()
  vim.api.nvim_create_autocmd("PackChanged", {
    group = vim.api.nvim_create_augroup("treesitter_update", { clear = true }),
    callback = function(args)
      local data = args.data
      if
        data.spec.name == "nvim-treesitter"
        and (data.kind == "install" or data.kind == "update")
      then
        if data.active then
          vim.cmd.TSUpdate()
        else
          update_required = true
        end
      end
    end,
  })
end

function M.setup()
  local treesitter = require("nvim-treesitter")
  treesitter.setup({})
  treesitter.install(parsers)

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup(
      "treesitter_features",
      { clear = true }
    ),
    callback = function(args)
      local filetype = vim.bo[args.buf].filetype
      local language = vim.treesitter.language.get_lang(filetype) or filetype

      if vim.treesitter.language.add(language) then
        vim.treesitter.start(args.buf, language)
        vim.bo[args.buf].indentexpr =
          "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })

  if update_required then
    vim.cmd.TSUpdate()
  end
end

return M

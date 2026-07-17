local M = {}

local update_required = false

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
  require("nvim-treesitter").setup({
    ensure_installed = {
      "lua",
      "vim",
      "vimdoc",
      "query",
      "markdown",
      "c",
    },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  })

  if update_required then
    vim.cmd.TSUpdate()
  end
end

return M

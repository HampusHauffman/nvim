---@type vim.lsp.ClientConfig
return {
  on_attach = function()
    local pipe_path = "/tmp/godot.pipe"
    local running = vim.tbl_contains(vim.fn.serverlist(), pipe_path)

    if vim.fn.filereadable(pipe_path) == 1 and not running then
      vim.fn.delete(pipe_path)
    end

    if not running then
      vim.fn.serverstart(pipe_path)
    end

    -- Remove the Godot server pipe when Neovim exits.
    vim.api.nvim_create_autocmd("VimLeave", {
      group = vim.api.nvim_create_augroup("godot_cleanup", { clear = true }),
      callback = function()
        if vim.fn.filereadable(pipe_path) == 1 then
          vim.fn.delete(pipe_path)
        end
      end,
    })
  end,
}

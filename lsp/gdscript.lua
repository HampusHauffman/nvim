-- =============================================================================
-- GODOT EDITOR SETTINGS (External Editor)
-- -----------------------------------------------------------------------------
-- Exec Path: /opt/homebrew/bin/nvim
-- Exec Flags: --server /tmp/godot.pipe --remote-send "<C-\><C-N>:e {file}<CR>:call cursor({line},{col})<CR>"
-- =============================================================================

---@type vim.lsp.ClientConfig
return {
  on_attach = function(client, bufnr)
    local pipe_path = "/tmp/godot.pipe"

    -- 1. STALE PIPE CLEANUP: If nvim crashed previously, the file might exist
    -- but not be in the active 'serverlist()'. We delete it to be safe.
    if vim.fn.filereadable(pipe_path) == 1 then
      if not vim.tbl_contains(vim.fn.serverlist(), pipe_path) then
        vim.fn.delete(pipe_path)
      end
    end

    -- 2. START SERVER: Only if this instance isn't already the server
    if not vim.tbl_contains(vim.fn.serverlist(), pipe_path) then
      pcall(vim.fn.serverstart, pipe_path)
    end

    -- 3. EXIT CLEANUP: For normal exits
    vim.api.nvim_create_autocmd("VimLeave", {
      group = vim.api.nvim_create_augroup("GodotCleanup", { clear = true }),
      callback = function()
        if vim.fn.filereadable(pipe_path) == 1 then
          vim.fn.delete(pipe_path)
        end
      end,
    })
  end,
}

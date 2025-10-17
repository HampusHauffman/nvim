return {
  on_attach = function(client, bufnr)
    -- Exec Path: /opt/homebrew/bin/nvim
    -- Exec Flags: --server {project}/server.pipe --remote-send "<C-\><C-N>:e {file}<CR>:call cursor({line}+1,{col})<CR>"
    -- Start server to listen to inputs from godot
    local pipe_path = vim.fn.getcwd() .. "/server.pipe"
    -- serverlist() returns a list of available server addresses
    if not vim.tbl_contains(vim.fn.serverlist(), pipe_path) then
      -- Start server to listen to inputs from Godot, only if not already started
      pcall(vim.fn.serverstart, pipe_path)
    end
  end,
}

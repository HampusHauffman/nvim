local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- resize splits if window got resized
autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line("'\"")
    if
      line > 1
      and line <= vim.fn.line("$")
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase", "http" }, vim.bo.filetype) == -1
    then
      vim.cmd('normal! g`"')
    end
  end,
})

-- Save on insert mode exit
autocmd("InsertLeave", {
  group = augroup("save_on_insert_leave"),
  callback = function()
    if vim.bo.modified and vim.bo.buftype == "" then
      vim.cmd("silent write")
    end
  end,
})

-- Hide tmux status bar when entering Neovim
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if os.getenv("TMUX") then
      os.execute("tmux set status off")
    end
  end,
})

-- Show tmux status bar when exiting Neovim
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    if os.getenv("TMUX") then
      os.execute("tmux set status on")
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp_attach"),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- gdscript specific setup
    if client.name == "gdscript" then
      -- Start server to listen to inputs from godot
      local pipe_path = vim.fn.getcwd() .. "/server.pipe"
      if not vim.tbl_contains(vim.fn.serverlist(), pipe_path) then
        -- Start server to listen to inputs from Godot, only if not already started
        pcall(vim.fn.serverstart, pipe_path)
      end
    end
  end,
})

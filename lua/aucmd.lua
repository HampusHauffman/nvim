local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
  return vim.api.nvim_create_augroup("config_" .. name, { clear = true })
end

-- Add quickfix-local close and delete mappings.
autocmd("FileType", {
  group = augroup("quickfix"),
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "q", "<cmd>cclose<cr>", {
      buffer = true,
      desc = "Close quickfix",
    })

    vim.keymap.set("n", "dd", function()
      local lnum = vim.fn.line(".")
      local qf = vim.fn.getqflist()
      table.remove(qf, lnum)
      vim.fn.setqflist(qf, "r")
      if #qf == 0 then
        vim.api.nvim_win_close(0, false)
      end
    end, { buffer = true, desc = "Delete quickfix entry" })
  end,
})

-- Equalize splits after resizing Neovim.
autocmd("VimResized", {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Restore the last cursor position when reopening a file.
autocmd("BufReadPost", {
  group = augroup("last_location"),
  callback = function()
    local line = vim.fn.line("'\"")
    if
        line > 1
        and line <= vim.fn.line("$")
        and vim.bo.filetype ~= "commit"
        and not vim.tbl_contains({ "xxd", "gitrebase", "http" }, vim.bo.filetype)
    then
      vim.cmd('normal! g`"')
    end
  end,
})

-- Save modified file buffers after leaving insert mode.
-- autocmd("InsertLeave", {
--   group = augroup("save_on_insert_leave"),
--   callback = function()
--     if vim.bo.modified and vim.bo.buftype == "" then
--       vim.cmd("silent write")
--     end
--   end,
-- })

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if
      vim.tbl_contains(exclude, vim.bo[buf].filetype)
      or vim.b[buf].lazyvim_last_loc
    then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})


-- Create an augroup for NoHLSearch
local nohl_group = vim.api.nvim_create_augroup("NoHLSearch", { clear = true })

-- Function to disable hlsearch after a certain time
local function nohl_after(n)
  if not vim.g.nohl_starttime then
    vim.g.nohl_starttime = os.time()
  else
    if vim.v.hlsearch == 1 and (os.time() - vim.g.nohl_starttime) >= n then
      vim.cmd("set nohlsearch")
      vim.g.nohl_starttime = nil
    end
  end
end

-- Create autocommands for CursorHold and CursorMoved
vim.api.nvim_create_autocmd({ "CursorHold", "CursorMoved" }, {
  group = nohl_group,
  callback = function()
    nohl_after(9)
  end,
})

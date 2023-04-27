local parsers = require('nvim-treesitter.parsers')
--- @return TSNode
local function get_root_node()
  ---@diagnostic disable-next-line
  local tree = parsers.get_parser():parse()[1]
  return tree:root()
end



vim.cmd('highlight Bloc0 guibg=#001234')
vim.cmd('highlight Bloc1 guibg=#004321')

local ns_id = vim.api.nvim_create_namespace('my_namespace')

function awd()
end

function awddddd()
end

---@param ts_node TSNode
---@param nest_nr integer
local function color_node(ts_node, nest_nr)
  local start_row, _, _ = ts_node:start()
  local end_row, _, _ = ts_node:end_()
  if (start_row == end_row) then return end
  print("start " .. start_row .. " end " .. end_row)

  for i in ts_node:iter_children() do
    color_node(i, nest_nr + 1)
  end
  if (ts_node:type() == "block") then nest_nr = nest_nr - 1 end
  vim.api.nvim_buf_set_extmark(0, ns_id, start_row, 0,
    { end_row = end_row, end_col = 0, hl_eol = true, hl_group = "Bloc" .. nest_nr % 2 }) -- highlight the entire row
end

function M()
  local l = get_root_node()

  color_node(l, 0)
end

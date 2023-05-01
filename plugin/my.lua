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
local function find_biggest_end_col(ts_node)
  local _, max, _ = ts_node:start()

  for c in ts_node:iter_children() do
    max = math.max(max, find_biggest_end_col(c))
  end
  return max
end

---@param ts_node TSNode
---@param nest_nr integer
---@param lines string[]
local function color_node(ts_node, nest_nr, lines, prev_max_col)
  local start_row, start_col, end_row, end_col = ts_node:range()
  local max_col = find_biggest_end_col(ts_node)

  if (start_row == end_row) then return end
  if (ts_node:type() == "arguments") then return end

  nest_nr = nest_nr + (ts_node:type() == "block" and -1 or 0)

  for row = start_row, end_row - (nest_nr == 0 and 1 or 0) do -- Figure out why i need this check
    local spaces = string.rep(" ", max_col - string.len(lines[row + 1]))
    local prev_spaces = string.rep(" ", prev_max_col - max_col)

    -- Fill out space to  longest char (spaces)
    vim.api.nvim_buf_set_extmark(0, ns_id, row, 0, {
      id = row + 1,
      virt_text = { { spaces, "Bloc" .. nest_nr % 2 }, { prev_spaces, "Bloc" .. (nest_nr - 1) % 2 } },
      virt_text_pos = "eol",
    })
  end

  for i in ts_node:iter_children() do
    color_node(i, nest_nr + 1, lines, max_col)
  end
end

function M()
  local root_node = get_root_node()
  local buf_lines = vim.api.nvim_buf_line_count(0)
  local lines = vim.api.nvim_buf_get_lines(0, 0, buf_lines, true)
  print(root_node:end_())

  color_node(root_node, 0, lines, find_biggest_end_col(root_node))
end

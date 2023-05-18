local M       = {}

local parsers = require('nvim-treesitter.parsers')

local api     = vim.api
local ts      = vim.treesitter
local ns_id   = vim.api.nvim_create_namespace('bloc')
vim.cmd('highlight Bloc0 guibg=#001234')
vim.cmd('highlight Bloc1 guibg=#004321')
vim.cmd('highlight Bloc2 guibg=#432100')

--- @type table<integer,{lang:string, parser:LanguageTree}>
local buffers = {}
--- @type table<integer>
local hl_ids = {}

local tabstop = vim.api.nvim_buf_get_option(0, "tabstop")
---@param lines string[]
local function find_biggest_end_col(lines)
	local max = 0
	for _, l in ipairs(lines) do
		max = math.max(max, #l)
	end
	return max
end

-- a func called tab_to_space that converts each tab to tabstop amount of spaces
---@param ts_node TSNode
---@param nest_nr integer
---@param lines string[]
---@return integer
local function color_node(ts_node, nest_nr, lines, prev_start_row, prev_end_col)
	local start_row, start_col, end_row, end_col = ts_node:range()
	local node_lines = { table.unpack(lines, start_row, end_row + 1) }
	local max_col = find_biggest_end_col(node_lines)
	local window_col = vim.fn.wincol()
	if (start_row >= end_row) then return 0 end
	-- Add the extmarks that make up the boxes
	if (start_row ~= prev_start_row) then
		for row = start_row, end_row do
			vim.api.nvim_buf_set_extmark(0, ns_id, row, 0, {
				virt_text = { { string.rep(" ", max_col - string.len(lines[row + 1])), "bloc" .. nest_nr % 3 } },
				virt_text_win_col = string.len(lines[row + 1]),
				priority = 1000 + nest_nr,
			})
			-- variable start col that is 0 if start col is 0 or startcol -1 if start col above 0
			vim.api.nvim_buf_add_highlight(0, ns_id, "bloc" .. nest_nr % 3, row, start_col, -1)
		end
	end
	-- Recurse into children
	local pad = 0
	for i in ts_node:iter_children() do
		pad = math.max(pad, color_node(i, nest_nr + 1, lines, start_row, max_col))
	end

	if (start_row ~= prev_start_row) then
		for row = start_row, end_row do
			vim.api.nvim_buf_set_extmark(0, ns_id, row, 0, {
				virt_text = { { string.rep(" ", pad), "bloc" .. nest_nr % 3 } },
				virt_text_win_col = max_col,
			})
		end
	end
	return pad+1
end

---@param bufnr integer
local function update(bufnr)
	local lang_tree = buffers[bufnr].parser
	local trees = lang_tree:trees()
	local ts_node = trees[1]:root()
	local sr, sc, er, ec = ts_node:range()
	local lines = vim.api.nvim_buf_get_lines(0, 0, er, true)
	for i, line in ipairs(lines) do
		local spaces = string.rep(" ", tabstop) -- Spaces equivalent to one tab
		local converted_line = string.gsub(line, "\t", spaces)
		lines[i] = converted_line
	end
	for i, val in ipairs(hl_ids) do
		vim.api.nvim_buf_del_extmark(0, ns_id, val)
		table.remove(hl_ids, i)
	end

	vim.api.nvim_buf_clear_namespace(0, ns_id, 0, #lines)
	color_node(ts_node, 0, lines, 0, 0)
end


---Update the parser for a buffer.
local function start()
	local bufnr = api.nvim_get_current_buf()
	local lang = parsers.get_buf_lang(bufnr)
	local parser = ts.get_parser(bufnr, lang)
	buffers[bufnr] = { lang = lang, parser = parser }
	parser:register_cbs({
		on_changedtree = function()
			update(bufnr)
		end
	})
end

function M.test()
	start()
end

return M
-- Define a new highlight group for the end-of-line character

--vim.api.nvim_buf_clear_namespace(0, ns_id, row, end_row - 1)
--local id = vim.api.nvim_buf_set_extmark(0, ns_id, row, 0, {
--line_hl_group = "Bloc" .. nest_nr % 2,
--	end_col = string.len(lines[row + 1]),
--	hl_group = "Bloc" .. nest_nr % 2,
--})
--table.insert(hl_ids, id)
--vim.api.nvim_buf_set_extmark(0, ns_id, row, 0, {
--	virt_text = { { "" .. row .. "-" ..nest_nr, "Normal" } }
--})

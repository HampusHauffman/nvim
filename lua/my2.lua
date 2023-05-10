local M       = {}

local parsers = require('nvim-treesitter.parsers')

local api     = vim.api
local ts      = vim.treesitter
local ns_id   = vim.api.nvim_create_namespace('bloc')
vim.cmd('highlight Bloc0 guibg=#001234')
vim.cmd('highlight Bloc1 guibg=#004321')

--- @type table<integer,{lang:string, parser:LanguageTree}>
local buffers = {}
local c       = 0

---@param lines string[]
local function find_biggest_end_col(lines)
	local max = 0
	for i = 1, #lines do
		max = math.max(max, #lines[i])
	end
	return max
end

---@param ts_node TSNode
---@param nest_nr integer
---@param lines string[]
local function color_node(ts_node, nest_nr, lines)
	local start_row, start_col, end_row, end_col = ts_node:range()
	local node_lines = { table.unpack(lines, start_row + 1, end_row) }
	local max_col = find_biggest_end_col(node_lines) + 1
	if (start_row == end_row) then return end
	if (ts_node:type() == "block") then ns_id = ns_id + 1 end

	--vim.api.nvim_buf_clear_namespace(0, ns_id, row + 1, end_row)
	for row = start_row, end_row do -- Figure out why i need this check
		vim.api.nvim_buf_clear_namespace(0, ns_id, row, row+1)
		vim.api.nvim_buf_set_extmark(0, ns_id, row, 0, {
			line_hl_group = "Bloc" .. nest_nr % 2,
			hl_group = "Bloc" .. nest_nr % 2,
			id = 100000 + row
		})
		--vim.api.nvim_buf_add_highlight(0, ns_id, "Bloc" .. nest_nr % 2, row + 1, start_col, -1)
	end
	for i in ts_node:iter_children() do
		color_node(i, nest_nr + 1, lines)
	end
end

--- srow scol erow ecol
---@param bufnr integer
local function update(bufnr)
	local lang_tree = buffers[bufnr].parser
	local trees = lang_tree:trees()
	local ts_node = trees[1]:root()
	local sr, sc, er, ec = ts_node:range()
	local lines = vim.api.nvim_buf_get_lines(0, 0, er, true)
	color_node(ts_node, 0, lines)
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
			c = c + 1
		end
	})
end

function M.test()
	start()
end

return M

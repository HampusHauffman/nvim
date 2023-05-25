local M       = {}

---@class MTSNode
---@field children MTSNode[]
---@field start_row integer
---@field end_row integer
---@field start_col integer
---@field end_col integer
---@field color integer
---@field pad integer
local MTSNode = {}

local parsers = require('nvim-treesitter.parsers')

--- @type table<integer,{lang:string, parser:LanguageTree}>
local buffers = {}
local tabstop = vim.api.nvim_buf_get_option(0, "tabstop")
local api     = vim.api
local ts      = vim.treesitter
local ns_id   = vim.api.nvim_create_namespace('bloc')
vim.cmd('highlight Bloc0 guibg=#001234')
vim.cmd('highlight Bloc1 guibg=#004321')
vim.cmd('highlight Bloc2 guibg=#432100')

---@param lines string[]
local function find_biggest_end_col(lines)
	local max = 0
	for _, i in ipairs(lines) do
		max = math.max(max, #i)
	end
	return max
end

-- Define the ModifiedTSNode class
---@param ts_node TSNode
---@param color integer
---@param lines string[]
---@return MTSNode
local function convert_ts_node(ts_node, color, lines)
	local start_row, start_col, end_row, _ = ts_node:range()
	local node_lines = { table.unpack(lines, start_row + 1, end_row) }
	local max_col = find_biggest_end_col(node_lines)
	local mts_node = {
		children = {},
		start_row = start_row,
		end_row = end_row,
		start_col = start_col,
		end_col = max_col,
		color = color,
		pad = 0,
	}
	for c in ts_node:iter_children() do
		local child_mts = convert_ts_node(c, color + 1, lines)
		if child_mts.start_row ~= start_row and child_mts.start_row ~= child_mts.end_row then
			table.insert(mts_node.children, child_mts)
			mts_node.pad = math.max(mts_node.pad, child_mts.pad)
		end
	end
	mts_node.pad = mts_node.pad + 1
	return mts_node
end

-- a func called tab_to_space that converts each tab to tabstop amount of spaces
---@param mts_node MTSNode
local function color_mts_node(mts_node, lines)
	for row = mts_node.start_row, math.min(#lines - 1, mts_node.end_row) do
		local str_len = string.len(lines[row + 1])
		vim.api.nvim_buf_set_extmark(0, ns_id, row, 0, {
			virt_text = {
				{ string.rep(" ", mts_node.end_col - str_len + mts_node.pad),
					"bloc" .. mts_node.color % 3 } },
			virt_text_win_col = str_len,
			priority = 1000 + mts_node.color,
		})
		local l = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
		if (#l < mts_node.start_col) then

		else
			vim.api.nvim_buf_set_extmark(0, ns_id, row, mts_node.start_col, {
				end_col = #l,
				hl_group = "bloc" .. mts_node.color % 3,
				priority = 1000 + mts_node.color,
			})
		end

		--vim.api.nvim_buf_add_highlight(0, ns_id, "bloc" .. mts_node.color % 3, row, mts_node.start_col, -1)
	end
	for _, child in ipairs(mts_node.children) do
		color_mts_node(child, lines)
	end
end

---@param bufnr integer
local function update(bufnr)
	local lang_tree = buffers[bufnr].parser
	local trees = lang_tree:trees()
	local ts_node = trees[1]:root()
	local sr, sc, er, ec = ts_node:range()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
	for i, line in ipairs(lines) do
		local spaces = string.rep(" ", tabstop) -- Spaces equivalent to one tab
		local converted_line = string.gsub(line, "\t", spaces)
		lines[i] = converted_line
	end
	vim.api.nvim_buf_clear_namespace(0, ns_id, 0, #lines)
	--color_node(ts_node, 0, lines, 0)
	local l = convert_ts_node(ts_node, 0, lines)
	color_mts_node(l, lines)
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
	xpcall(start, function(err)
		print(err)
	end)
end

--ath
return M

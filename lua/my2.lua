local M       = {}

local parsers = require('nvim-treesitter.parsers')

local api     = vim.api
local ts      = vim.treesitter

--- @type table<integer,{lang:string, parser:LanguageTree}>
local buffers = {}
local c       = 0

--- srow scol erow ecol
---@param bufnr integer
local function update(bufnr)
	local lang_tree = buffers[bufnr].parser
	local trees = lang_tree:trees()
	local tree = trees[1]:root()
	local sr, sc, er, ec = tree:range()
	print("HERE " .. sr .. " " .. sc .. " " .. er .. " " .. " " .. ec)
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

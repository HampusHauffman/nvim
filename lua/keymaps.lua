local M = {}
-----------------------------------------------------------
-- Key maps
-----------------------------------------------------------
local wk = require "which-key"

local function map(mode, lhs, rhs, desc)
	local options = { noremap = true, silent = true }
	vim.keymap.set(mode, lhs, rhs, options)
	if desc then
		wk.register({ [lhs] = desc },
			{ mode = mode })
	end
end

-- Change leader to a space (Also done in init)
vim.g.mapleader = " "
-- Telescope builtins for lsp actions
local tele_builtin = require("telescope.builtin")
-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------
-- Disable arrow keys to be 1337
map("", "<up>", "<nop>")
map("", "<down>", "<nop>")
map("", "<left>", "<nop>")
map("", "<right>", "<nop>")

-- Move to end with ö
map("n", "ö", "$")
map("v", "ö", "$")

-- Map Esc to kk and jj
map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")

-- Move in insert mode
map("i", "<C-h>", "<left>")
map("i", "<C-j>", "<down>")
map("i", "<C-k>", "<up>")
map("i", "<C-l>", "<right>")

-- Move around splits using Ctrl + {h,j,k,l}
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

vim.cmd [[
  set wildcharm=<Tab>
  cnoremap <C-j> <Tab>
  cnoremap <C-k> <S-Tab>
]]

-- Fast saving with <leader> and s
map("n", "<leader>s", ":w<CR>", "Save file 💾")

-- Quit with leader shift q
map("n", "<leader><S-q>", ":qa!<CR>")

-- Tmux navigation
map("n", "<C-h>", ":<C-U>TmuxNavigateLeft<cr>")
map("n", "<C-j>", ":<C-U>TmuxNavigateDown<cr>")
map("n", "<C-k>", ":<C-U>TmuxNavigateUp<cr>")
map("n", "<C-l>", ":<C-U>TmuxNavigateRight<cr>")
-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------


map({ "n", "x", "o" }, "s", function() require("flash").jump() end, "Flash")
map({ "n", "o", "x" }, "S", function() require("flash").treesitter() end, "Flash Treesitter")
map("o", "r", function() require("flash").remote() end, "Remote Flash")
map({ "o", "x" }, "R", function() require("flash").treesitter_search() end, "Treesitter Search")
map({ "c" }, "<c-s>", function() require("flash").toggle() end, "Toggle Flash Search")

-----------------------------------------------------------
-- Neotree
-----------------------------------------------------------
map("n", "<leader><s-n>", ":Neotree left focus reveal<CR>", "File explorer")
-- To make neotree open in current buf if we're in zen mode (ZENENABLED is defined in zen_mode.lua)
-- This also makes sure if there is a buffer open (like one opened to the left) we go to that one instead of opening a new one
map("n", "<leader>n", function()
	-- Open previous if we're in neotree
	if vim.api.nvim_get_option_value("filetype", { buf = 0 }) == "neo-tree" then
		vim.cmd("bprevious")
	end
	-- If zenmode is enabled open neotree in the current buff
	if vim.g.ZENENABLED == true then
		local currentFilePath = vim.fn.expand('%:p')
		if currentFilePath == "" or currentFilePath == nil then
			vim.cmd("Neotree toggle reveal current")
		else
			-- this can fail if we're in a neotree buffer and as such we should just toggle
			local success, _ = pcall(function()
				vim.cmd("Neotree reveal_file=" .. currentFilePath .. " current")
			end)
			if not success then
				vim.cmd("Neotree toggle reveal current")
			end
		end
		-- If we're not in zen mode then open neotree in float unless there is already a buffer open called neotre
	else
		-- Check if there's a buffer with filetype "neo-tree"
		local neotreeBuffer = nil
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			--get buffer number from win
			local buffer = vim.api.nvim_win_get_buf(win)
			local filetype = vim.api.nvim_get_option_value('filetype', { buf = buffer })
			if filetype == 'neo-tree' then
				neotreeBuffer = buffer
				break
			end
		end

		if neotreeBuffer then
			vim.cmd("Neotree left focus reveal")
		else
			vim.cmd("Neotree toggle filesystem reveal float")
		end
	end
end)

-----------------------------------------------------------
-- GitSign
-----------------------------------------------------------
map("n", "<C-g>", ":Gitsigns <cr>")

-----------------------------------------------------------
-- LazyGit
-----------------------------------------------------------
map("n", "git", function()
	local Terminal = require("toggleterm.terminal").Terminal
	local lazygit  = Terminal:new({
		cmd = "lazygit",
		hidden = true,
		direction = "float"
	})
	lazygit:toggle()
end, "💤 Git")

-----------------------------------------------------------
--  Terminal
-----------------------------------------------------------
map("n", "<C-t>", ":ToggleTerm<CR>", "Terminal")
map("t", "<C-t>", ":ToggleTerm<CR>", "Terminal")
map("n", "v:count1 <C-t>", ":v:count1" .. '"ToggleTerm"<CR>')
map("v", "v:count1 <C-t>", ":v:count1" .. '"ToggleTerm"<CR>')

map("t", "<esc>", [[<C-\><C-n>]])
--map("t", "jk", [[<C-\><C-n>]])
--map("t", "kj", [[<C-\><C-n>]])
--map("t", "<C-h>", [[<Cmd>wincmd h<CR>]])
--map("t", "<C-j>", [[<Cmd>wincmd j<CR>]])
--map("t", "<C-k>", [[<Cmd>wincmd k<CR>]])
--map("t", "<C-l>", [[<Cmd>wincmd l<CR>]])

-----------------------------------------------------------
-- Telescope
-----------------------------------------------------------
map("n", "ff", tele_builtin.find_files, "Find files")
map("n", "fa", function()
	tele_builtin.lsp_document_symbols({
		--symbols = {}
	})
end, "Document symbols")
map("n", "fg", tele_builtin.live_grep, "Find grep")
--map("n", "fg", function()
--	require('telescope.builtin').grep_string {
--		shorten_path = true, word_match = "-w", only_sort_text = true, search = ''
--	}
--end, "Find grep")
map("n", "fo", tele_builtin.find_files, "Find files")
map("n", "<leader>e", function()
	tele_builtin.oldfiles({ only_cwd = true })
end, "Previous files")
map("n", "fb", tele_builtin.buffers)
map("n", "fh", tele_builtin.help_tags)

require("telescope").setup {
	defaults = {
		winblend = 0,
		mappings = {
			n = {
				["kj"] = "close",
				["jk"] = "close",
			},
			i = {
				["<S-Tab>"] = "move_selection_previous",
				["<Tab>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
				["<C-j>"] = "move_selection_next",
			},
		},
	}
}

-----------------------------------------------------------
-- LSP
-----------------------------------------------------------
map("n", "<leader>f", function() vim.lsp.buf.format({}) end, "Format")
map("v", "<leader>f", function() vim.lsp.buf.format({}) end, "Format")
map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
map("n", "gr", function()
	tele_builtin.lsp_references({
		fname_width = 1000,
		show_line = false,
	})
end, "Go to reference")
map("n", "gd", tele_builtin.lsp_definitions, "Go to defenition")
map("n", "K", vim.lsp.buf.hover, "Hover")
map("n", "<leader>r", function()
	vim.lsp.buf.rename()
	vim.cmd('silent! wa')
end, "Rename")
map("n", "<leader>c", vim.lsp.buf.code_action, "Code action")
map("v", "<leader>c", vim.lsp.buf.code_action, "Code action")
map("n", "<f14>", vim.diagnostic.goto_prev, "Go to previous fix")
map("n", "<S-f2>", vim.diagnostic.goto_prev, "Go to previous fix")
map("n", "<f2>", vim.diagnostic.goto_next, "Go to next fix")


-----------------------------------------------------------
-- AutoComplete
-----------------------------------------------------------
local luasnip = require("luasnip")
local cmp = require("cmp")
local next = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif luasnip.expandable() then
			luasnip.expand()
		elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		else
			fallback()
		end
	end,
	{
		"i",
		"s",
	})
local prev = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif luasnip.jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end,
	{
		"i",
		"s",
	})

M.cmp = {
	["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
	["<CR>"] = cmp.mapping.confirm({ select = false }),
	["<Tab>"] = next,
	["<S-Tab>"] = prev,
	["<C-j>"] = next,
	["<C-k>"] = prev,
}

-----------------------------------------------------------
--  Treesitter
-----------------------------------------------------------
-- Shift up and down to make larger selections easely
M.treesitter = {
	init_selection = "<leader> v",
	node_incremental = "<C-k>",
	node_decremental = "<C-j>",
}

-----------------------------------------------------------
--  ZenMode
-----------------------------------------------------------
map("n", "<leader>z", function()
		vim.cmd("zenmode")
	end,
	"🧘")

return M

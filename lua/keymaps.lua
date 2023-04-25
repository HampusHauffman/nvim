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

-- Change leader to a space
vim.g.mapleader = " "

map("n", "<leader>å", ":source $MYVIMRC <CR>", "Source $MYVIMRC!")
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

-- Fast saving with <leader> and s
map("n", "<leader>s", ":w<CR>", "Save file")

-- Quit with leader shift q
map("n", "<leader><S-q>", ":qa!<CR>")

-- Tmux navigation
map("n", "<C-h>", ":<C-U>TmuxNavigateLeft<cr>")
map("n", "<C-j>", ":<C-U>TmuxNavigateDown<cr>")
map("n", "<C-k>", ":<C-U>TmuxNavigateUp<cr>")
map("n", "<C-l>", ":<C-U>TmuxNavigateRight<cr>")
--map("n","<C-h>",":<C-U>TmuxNavigatePrevious<cr>")
-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-----------------------------------------------------------
-- Neotree
-----------------------------------------------------------
map("n", "<leader>n", ":Neotree left focus reveal<CR>", "File explorer")
--map("n", "<leader><s-n>", ":Neotree git_status left focus reveal<CR>")

-- To also work with CTRL
-- map("n", "<c-n>", ":Neotree left focus reveal<CR>")
-----------------------------------------------------------
-- Telescope
-----------------------------------------------------------
-- Telescope builtins for lsp actions
local builtin = require("telescope.builtin")

map("n", "ff", builtin.find_files, "Find files")
map("n", "fg", builtin.live_grep, "Find grep")
map("n", "fo", builtin.find_files, "Find files")
map("n", "<leader>e", function()
	builtin.oldfiles({ only_cwd = true })
end, "Previous files")
map("n", "fb", builtin.buffers)
map("n", "fh", builtin.help_tags)

M.telescope = {
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
}
-----------------------------------------------------------
-- LSP
-----------------------------------------------------------
map("n", "<leader>f", function()
	vim.lsp.buf.format({
		timeout_ms = 2000,
		asnyc = true,
		filter = function(client)
			return client.name ~= "tsserver"
		end,
	})
end, "Format")
map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
map("n", "gr", function()
	builtin.lsp_references({
		fname_width = 1000,
		show_line = false,
	})
end, "Go to reference")
map("n", "gd", builtin.lsp_definitions, "Go to defenition")
map("n", "K", vim.lsp.buf.hover, "Hover")
map("n", "<leader>r", vim.lsp.buf.rename, "Rename")
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
end, {
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
end, {
	"i",
	"s",
})

M.cmp = {
	["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
	["<CR>"] = cmp.mapping.confirm({ select = true }),
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
	init_selection = "<s-up>",
	node_incremental = "<s-up>",
	node_decremental = "<S-down>",
}

-----------------------------------------------------------
--  Terminal
-----------------------------------------------------------
map("n", "<C-t>", ":ToggleTerm<CR>", "Terminal")
map("t", "<C-t>", ":ToggleTerm<CR>", "Terminal")
map("n", "v:count1 <C-t>", ":v:count1" .. '"ToggleTerm"<CR>')
map("v", "v:count1 <C-t>", ":v:count1" .. '"ToggleTerm"<CR>')

map("t", "<esc>", [[<C-\><C-n>]])
map("t", "jk", [[<C-\><C-n>]])
map("t", "kj", [[<C-\><C-n>]])
map("t", "<C-h>", [[<Cmd>wincmd h<CR>]])
map("t", "<C-j>", [[<Cmd>wincmd j<CR>]])
map("t", "<C-k>", [[<Cmd>wincmd k<CR>]])
map("t", "<C-l>", [[<Cmd>wincmd l<CR>]])

-----------------------------------------------------------
--  ZenMode
-----------------------------------------------------------
local function zen()
	vim.fn.system("tmux resize-pane -Z")
end
map("n", "<leader>z", function ()
	zen()
	vim.cmd("ZenMode")
end, "🧘")


return M

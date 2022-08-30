local M = {}
-----------------------------------------------------------
-- Key maps
-----------------------------------------------------------
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a space
vim.g.mapleader = " "
vim.cmd [[nnoremap <Space> <Nop>]]

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Disable arrow keys to be 1337
map("", "<up>", "<nop>")
map("", "<down>", "<nop>")
map("", "<left>", "<nop>")
map("", "<right>", "<nop>")

map("n","ö","$")

-- Map Esc to kk and jj
map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")

-- Toggle auto-indenting for code paste
--map("n", "<F2>", ":set invpaste paste?<CR>")

-- Move around splits using Ctrl + {h,j,k,l}
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Fast saving with <leader> and s
map("n", "<leader>s", ":w<CR>")

-- Quit with leader shift q
map("n", "<leader><S-q>", ":qa!<CR>")

-- Reload source
map("n", "<leader><S-z>", ":so ~/.config/nvim/init.lua<CR>")


-- Reload current file
map("n", "<leader>r", ":so %<CR>")

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-----------------------------------------------------------
-- Neotree
-----------------------------------------------------------
map("n", "<leader>n", ":Neotree left focus reveal<CR>")

-----------------------------------------------------------
-- LSP
-----------------------------------------------------------

map("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>")
map("n", "<leader>c", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("v", "<leader>c", "<cmd>lua vim.lsp.buf.range_code_action()<CR>")
map("n", "<f14>", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "<f2>", "<cmd>lua vim.diagnostic.goto_next()<CR>")
--map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
map("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")

-----------------------------------------------------------
-- Telescope
-----------------------------------------------------------
-- map("n", "E", "<cmd>lua require('telescope.builtin').oldfiles()<cr>")
map("n", "ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map("n", "fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("n", "<leader>e", "<cmd>lua require('telescope.builtin').oldfiles()<cr>")
map("n", "fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
map("n", "fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")

M.telescope = {
    i = {
        ["kj"] = "close",
        ["jk"] = "close",
        ["<TAB>"] = "cycle_history_next",
        ["<S-TAB>"] = "cycle_history_previous",
    }
}

-----------------------------------------------------------
-- AutoComplete
-----------------------------------------------------------
local luasnip = require "luasnip"
local cmp = require "cmp"
M.cmp = {
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable,
    ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close(), },
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
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
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
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
    }),
}

-----------------------------------------------------------
--  Treesitter
-----------------------------------------------------------
M.treesitter = {
    init_selection = "<S-up>",
    node_incremental = "<S-up>",
    node_decremental = "<S-down>"
}
-----------------------------------------------------------
--  Terminal
-----------------------------------------------------------
map("n", "<C-t>", '<Cmd>execute v:count . "ToggleTerm size=10"<CR>', {
    silent = true,
    noremap = true,
})
map("t", "<esc>", [[<C-\><C-n>]])
--map("t", "jk", [[<C-\><C-n>]])
--map("t", "kj", [[<C-\><C-n>]])
map("t", "<C-h>", [[<Cmd>wincmd h<CR>]])
map("t", "<C-j>", [[<Cmd>wincmd j<CR>]])
map("t", "<C-k>", [[<Cmd>wincmd k<CR>]])
map("t", "<C-l>", [[<Cmd>wincmd l<CR>]])

return M

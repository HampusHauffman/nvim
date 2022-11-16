local M = {}

-----------------------------------------------------------
-- Key maps
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
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
map("n", "<leader>s", ":w<CR>")

-- Quit with leader shift q
map("n", "<leader><S-q>", ":qa!<CR>")

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-----------------------------------------------------------
-- Neotree
-----------------------------------------------------------
map("n", "<leader>n", ":Neotree left focus reveal<CR>")
map("n", "<leader><s-n>", ":Neotree git_status left focus reveal<CR>")

-----------------------------------------------------------
-- Telescope
-----------------------------------------------------------
-- Telescope builtins for lsp actions
local builtin = require "telescope.builtin"

map("n", "ff", builtin.find_files)
map("n", "fg", builtin.live_grep)
map("n", "fo", builtin.find_files)
map("n", "<leader>e", function()
    builtin.oldfiles({ only_cwd = true })
end)
map("n", "fb", builtin.buffers)
map("n", "fh", builtin.help_tags)
map("n", "<leader>a", function()
    builtin.lsp_document_symbols({ ignore_symbols = { "property", "constant" } })
end)

M.telescope = {
    i = {
        ["kj"] = "close",
        ["jk"] = "close",
        ["<S-Tab>"] = "move_selection_previous",
        ["<Tab>"] = "move_selection_next"
    },
}
-----------------------------------------------------------
-- LSP
-----------------------------------------------------------

map("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({asnyc = true})<CR>")
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
map("n", "gr", function()
    builtin.lsp_references(require("telescope.themes").get_cursor({
        layout_config = {
            width = 0.7,
        }
    }
    ))
end)
map("n", "gd", builtin.lsp_definitions)
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>")
map("n", "<leader>c", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("v", "<leader>c", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("n", "<f14>", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "<S-f2>", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "<f2>", "<cmd>lua vim.diagnostic.goto_next()<CR>")
--map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
map("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")


-----------------------------------------------------------
-- AutoComplete
-----------------------------------------------------------
local luasnip = require "luasnip"
local cmp = require "cmp"
M.cmp = {
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
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
-- Shift up and down to make larger selections easely
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

map("t", "<C-t>", '<Cmd>execute v:count . "ToggleTerm size=10"<CR>', {
    silent = true,
    noremap = true,
})
map("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>") -- Function defined in terminal

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
map("n", "<leader>z", [[<Cmd>ZenMode<CR>]])

-----------------------------------------------------------
--  Aerial
-----------------------------------------------------------
--map("n", "<leader>a", [[<Cmd>AerialToggle<CR>]])

return M

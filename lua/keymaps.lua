-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a comma
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

-- Map Esc to kk and jj
map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")

-- Toggle auto-indenting for code paste
map("n", "<F2>", ":set invpaste paste?<CR>")

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
map("n", "<leader>n", ":Neotree focus reveal_force_cwd<CR>")

-----------------------------------------------------------
-- LSP
-----------------------------------------------------------

map("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
-- map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
map("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
map("n", "<f6>", "<cmd>lua vim.lsp.buf.rename()<CR>")
map("n", "<leader>c", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("n", "<f14>", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "<f2>", "<cmd>lua vim.diagnostic.goto_next()<CR>")

-----------------------------------------------------------
-- Telescope
-----------------------------------------------------------

-- map("n", "E", "<cmd>lua require('telescope.builtin').oldfiles()<cr>")
map("n", "ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map("n", "fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("n", "<leader>e", "<cmd>lua require('telescope.builtin').oldfiles()<cr>")
map("n", "fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
map("n", "fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")

require("telescope").setup {
    defaults = {
        mappings = {
            i = {
                ["kj"] = "close",
                ["jk"] = "close",
                ["<TAB>"] = "move_selection_previous",
                ["<S-TAB>"] = "move_selection_next",
            },
        },
    },
}


-----------------------------------------------------------
-- AutoComplete
-----------------------------------------------------------
local luasnip = require "luasnip"

local cmp = require "cmp"
cmp.setup {
    mapping = {
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable,
        ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
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
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<CR>"] = cmp.mapping.confirm { select = true },
}


require("gitsigns").setup {

    on_attach = function(bufnr)
        -- Actions
        map("n", "<leader>gs", ":Gitsigns stage_hunk<CR>")
        map("v", "<leader>gs", ":Gitsigns stage_hunk<CR>")
        map("n", "<leader>gr", ":Gitsigns reset_hunk<CR>")
        map("v", "<leader>gr", ":Gitsigns reset_hunk<CR>")
        map("n", "<leader>gS", "<cmd>Gitsigns stage_buffer<CR>")
        map("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>")
        map("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<CR>")
        map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>")
        map("n", "<leader>gb", '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
        map("n", "<leader>tB", "<cmd>Gitsigns toggle_current_line_blame<CR>")
        map("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>")
        map("n", "<leader>gD", "<cmd>Gitsigns toggle_deleted<CR>")

        -- Text object
--        map("o", "ih", ":<C-U>Gitsigns select_hunk<CR>")
--        map("x", "ih", ":<C-U>Gitsigns select_hunk<CR>")
    end

}

-- Terminal
vim.cmd [[autocmd TermEnter term://*toggleterm#* tnoremap <silent><leader>t <Cmd>exe v:count1 . "ToggleTerm"<CR>]]
vim.cmd [[nnoremap <silent><leader>t <Cmd>exe v:count1 . "ToggleTerm"<CR>]]
-- vim.cmd [[inoremap <silent><leader>T <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>]]


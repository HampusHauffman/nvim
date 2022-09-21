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

-- Move to end with ö
map("n", "ö", "$")

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

-- Reload source
map("n", "<leader><S-z>", ":so ~/.config/nvim/init.lua<CR>")

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-----------------------------------------------------------
-- Neotree
-----------------------------------------------------------
map("n", "<leader>n", ":Neotree left focus reveal<CR>")
map("n", "<leader>N", ":Neotree float git_status<CR>")
M.neotreefile = {
    ["<bs>"] = "navigate_up",
    ["."] = "set_root",
    ["H"] = "toggle_hidden",
    ["/"] = "fuzzy_finder",
    ["D"] = "fuzzy_finder_directory",
    ["f"] = "filter_on_submit",
    ["<c-x>"] = "clear_filter",
    ["[g"] = "prev_git_modified",
    ["]g"] = "next_git_modified",
}

M.neotreegit = {
    ["A"]  = "git_add_all",
    ["gu"] = "git_unstage_file",
    ["ga"] = "git_add_file",
    ["gr"] = "git_revert_file",
    ["gc"] = "git_commit",
    ["gp"] = "git_push",
    ["gg"] = "git_commit_and_push",
}

M.neotree = {
    ["<space>"] = {
        "toggle_node",
        nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
    },
    ["<2-LeftMouse>"] = "open",
    ["<cr>"] = "open",
    ["S"] = "open_split",
    ["s"] = "open_vsplit",
    -- ["S"] = "split_with_window_picker",
    -- ["s"] = "vsplit_with_window_picker",
    ["t"] = "open_tabnew",
    ["w"] = "open_with_window_picker",
    ["C"] = "close_node",
    ["z"] = "close_all_nodes",
    --["Z"] = "expand_all_nodes",
    ["a"] = {
        "add",
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
            show_path = "none" -- "none", "relative", "absolute"
        }
    },
    ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
    ["d"] = "delete",
    ["r"] = "rename",
    ["y"] = "copy_to_clipboard",
    ["x"] = "cut_to_clipboard",
    ["p"] = "paste_from_clipboard",
    ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
    -- ["c"] = {
    --  "copy",
    --  config = {
    --    show_path = "none" -- "none", "relative", "absolute"
    --  }
    --}
    ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
    ["q"] = "close_window",
    ["R"] = "refresh",
    ["?"] = "show_help",
    ["<"] = "prev_source",
    [">"] = "next_source",
}
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
map("n", "<S-f2>", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "<f2>", "<cmd>lua vim.diagnostic.goto_next()<CR>")
--map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
map("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")

-----------------------------------------------------------
-- Telescope
-----------------------------------------------------------
map("n", "ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map("n", "fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("n", "<leader>e", "<cmd>lua require('telescope.builtin').oldfiles()<cr>")
map("n", "fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
map("n", "fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")

M.telescope = {
    i = {
        ["kj"] = "close",
        ["jk"] = "close",
        ["<Tab>"] = "move_selection_previous",
        ["<S-Tab>"] = "move_selection_next"
    },
}

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
map("n", "<leader>a", [[<Cmd>AerialToggle<CR>]])

return M

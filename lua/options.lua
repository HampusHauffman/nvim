-- :set buflisted makes the buff show up in ls
vim.api.nvim_create_user_command("AWD", function()
    --   print(vim.api.nvim_buf_get_name(0))
    --  --   print(vim.api.nvim_win_get_number(vim.api.nvim_get_current_win()))
    local window_handle = vim.api.nvim_get_current_win()
    --    print(vim.api.nvim_buf_get_name(0))
    --   vim.api.nvim_win_set_width(window_handle, 38)
    --   vim.api.nvim_win_set_buf("neo")

    -- Get bufNr and convert to win id
    local win_number = vim.api.nvim_exec([[
            echo bufwinid(bufnr("neo-tree"))
        ]],
        true)
    if (tonumber(win_number) ~= -1) then
        vim.api.nvim_win_set_width(tonumber(win_number), 30)
    end
    print(win_number)

end, {})




-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- [2] Defaults - *nvim-defaults*

local g = vim.g -- Global variables
local opt = vim.opt -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = "a" -- Enable mouse support
opt.clipboard = "unnamedplus" -- Copy/paste to system clipboard
opt.swapfile = false -- Don't use swapfile
-- opt.completeopt = 'menuone,noinsert,noselect' -- Autocomplete options
opt.undofile = true -- Persistant undo
opt.cul = true
opt.autowriteall = true -- Auto write any changes. No more :qa! horrors :)

-----------------------------------------------------------
-- Color
-----------------------------------------------------------
vim.cmd [[colorscheme dracula]]
local colors = require "dracula".colors()
local highlight = function(group, fg, bg)
    fg = fg and "guifg=" .. fg or "guifg=NONE"
    bg = bg and "guibg=" .. bg or "guibg=NONE"

    vim.api.nvim_command("highlight " .. group .. " " .. fg .. " " .. bg)
end
highlight("NeoTreeNormal", colors.fg, colors.menu)
highlight("NeoTreeNormalNC", colors.fg, colors.menu)
highlight("VertSplit", colors.menu, colors.menu)
highlight("NeoTreeFloatBorder", colors.menu, colors.menu)
highlight("NeoTreeFloatTitle", colors.menu, colors.menu)
highlight("NeoTreeTitleBar", colors.fg, colors.menu)
highlight("MsgArea", colors.cyan, colors.menu)
highlight("CursorLineNr", colors.cyan, nil)
-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true -- Show line number
opt.relativenumber = true
opt.showmatch = true -- Highlight matching parenthesis
opt.foldmethod = "marker" -- Enable folding (default 'foldmarker')
-- opt.colorcolumn = '80' -- Line lenght marker at 80 columns
opt.splitright = true -- Vertical split to the right
opt.splitbelow = true -- Horizontal split to the bottom
opt.ignorecase = true -- Ignore case letters when search
opt.smartcase = true -- Ignore lowercase for the whole pattern
opt.linebreak = true -- Wrap on word boundary
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.laststatus = 3 -- Set global statusline

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 4 -- Shift 4 spaces when tab
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.smartindent = true -- Autoindent new linespt.smartindent = true      -- Autoindent new lines

-----------------------------------------------------------
-- List
-----------------------------------------------------------

opt.list = true
-- opt.listchars:append "eol:↴"
-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true -- Enable background buffers
opt.history = 100 -- Remember N lines in history
opt.lazyredraw = true -- Faster scrolling
opt.synmaxcol = 240 -- Max column for syntax highlight
opt.updatetime = 700 -- ms to wait for trigger an event

-----------------------------------------------------------
-- Plugins
-----------------------------------------------------------
opt.timeoutlen = 500
-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
opt.shortmess:append "sI"
-- Open Neotree

-- Disable builtin plugins
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
    "tutor",
    "rplugin",
    "synmenu",
    "optwin",
    "compiler",
    "bugreport",
    "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end

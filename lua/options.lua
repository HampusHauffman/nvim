-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------
local g            = vim.g   -- Global variables
local opt          = vim.opt -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
--vim.opt.wildcharm = '<Tab>'
opt.mouse          = "a"           -- Enable mouse support
opt.clipboard      = "unnamedplus" -- Copy/paste to system clipboard
opt.swapfile       = true          -- Don't use swapfile
opt.undofile       = true          -- Persistant undo
--opt.cul = true -- Line for the cursor
opt.autowrite      = true          -- Auto save file when it's not focused
opt.autowriteall   = true          -- Auto write any changes. No more :qa! horrors :)--------------------
opt.splitkeep      = "screen"
--opt.more

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.smoothscroll   = true
opt.wrap           = false    -- Disable line wrap
opt.number         = true     -- Show line number
opt.relativenumber = true
opt.showmatch      = false    -- Highlight matching parenthesis
opt.foldmethod     = "marker" -- Enable folding (default 'foldmarker')
-- opt.colorcolumn = '80' -- Line lenght marker at 80 columns
opt.splitright     = true     -- Vertical split to the right
opt.splitbelow     = true     -- Horizontal split to the bottom
opt.ignorecase     = true     -- Ignore case letters when search
opt.smartcase      = true     -- Ignore lowercase for the whole pattern
opt.linebreak      = true     -- Wrap on word boundary
--opt.wrap = false          -- Disable line wrap
opt.termguicolors  = true     -- Enable 24-bit RGB colors
opt.equalalways    = false
opt.signcolumn     = "yes:1"

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
--opt.expandtab      = true
opt.shiftwidth     = 4    -- Shift 4 spaces when tab
opt.tabstop        = 4    -- 1 tab == 4 spaces
opt.smartindent    = true -- Autoindent new linespt.smartindent = true      -- Autoindent new lines

-- StatusLine
opt.laststatus     = 3 -- Set global statusline
opt.cmdheight      = 0
-----------------------------------------------------------
-- List
-----------------------------------------------------------
opt.list           = true
--opt.listchars:append("eol:,")
--opt.endofline = false

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden         = true  -- Enable background buffers
opt.history        = 1000   -- Remember N lines in history
opt.lazyredraw     = false -- Faster scrolling true / smoother animations false
opt.synmaxcol      = 240   -- Max column for syntax highlight
opt.updatetime     = 700   -- ms to wait for trigger an event

-----------------------------------------------------------
-- Plugins
-----------------------------------------------------------
opt.timeoutlen     = 500

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

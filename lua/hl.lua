-- This is loaded after the colorscheme
local hl = vim.api.nvim_set_hl
hl(0, "ColorColumn", { bg = "#020202" })
hl(0, "Normal", { bg = "#000000" })
hl(0, "Pmenu", { link = "Normal" })
hl(0, "Search", { bg = "none", fg = "none", underline = true })
hl(0, "IncSearch", { bg = "none", fg = "none", underline = true })
hl(0, "CurSearch", { bg = "none", fg = "none", underline = true })

-- Mini.diff overlay highlights
hl(0, "MiniDiffOverAdd", { bg = "#081408" })
hl(0, "MiniDiffOverDelete", { bg = "#140808" })
hl(0, "MiniDiffOverChange", { bg = "#080814" })
hl(0, "MiniDiffOverContext", { bg = "#101010" })

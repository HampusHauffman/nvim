require("zen-mode").setup({
	window = {
		backdrop = 1,                      -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
		height = 0.90,                     -- height of the Zen window
		lazyions = {
			signcolumn = "no",             -- disable signcolumn
		},
		kitty = {
			enabled = false,
			font = "+4",                            -- font size increment
		},
		gitsigns = { enabled = false },             -- disables git signs
	},
})

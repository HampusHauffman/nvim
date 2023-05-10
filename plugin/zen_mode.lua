require("zen-mode").setup {
	window = {
		backdrop = 1,      -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
		height = 0.90,     -- height of the Zen window
		options = {
			signcolumn = "no", -- disable signcolumn
			number = false, -- disable number column
			relativenumber = false, -- disable relative numbers
			-- cursorline = false, -- disable cursorline
			cursorcolumn = false, -- disable cursor column
			-- foldcolumn = "0", -- disable fold column
			list = false,  -- disable whitespace characters
		},
	},
	plugins = {
		gitsigns = { enabled = true }, -- disables git signs
		--tmux = { enabled = true }, -- disables the tmux statusline
		kitty = {
			enabled = true,
			--font = "+4", -- font size increment
		},
	},
	-- callback where you can add custom code when the Zen window opens
	on_open = function(win)
		local zoomed = tonumber(vim.fn.system("tmux display -p -F '#{window_zoomed_flag}'"))
		if (zoomed == 0) then
			vim.fn.system("tmux resize-pane -Z")
			vim.fn.system("tmux set-option status")
		end
	end,
	-- callback where you can add custom code when the Zen window closes
	on_close = function()
		local zoomed = tonumber(vim.fn.system("tmux display -p -F '#{window_zoomed_flag}'"))
		if (zoomed == 1) then
			vim.fn.system("tmux resize-pane -Z")
			vim.fn.system("tmux set-option status")
		end
	end,

}

local M = {}
M[#M + 1] = {
	"folke/noice.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		--"rcarriga/nvim-notify",
	},
	config = function()
		require("noice").setup({
			routes = {
				{
					filter = {
						event = "notify",
						min_height = 15
					},
					view = 'split'
				},
			},
			cmdline = {
				view = "cmdline_popup",
			},
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = false, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = false, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
		})

		local ok, lualine = pcall(require, "lualine")
		if ok then
			lualine.setup({
				sections = {
					lualine_x = {
						{
							require("noice").api.status.mode.get,
							cond = require("noice").api.status.mode.has,
							color = { fg = "#ff9e64" },
						}
					},
				},
			})
		end
	end
}
return M

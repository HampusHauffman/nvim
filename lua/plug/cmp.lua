local M = {}
-----------------------------------------------------
-- CMP
-----------------------------------------------------
M[#M + 1] = {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lua",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
	},
	config = function(_, opts)
		-- Add additional capabilities supported by nvim-cmp
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local luasnip = require("luasnip")
		local cmp = require("cmp")

		-- Set lsp capabilities
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
		-- Luasnip
		luasnip.setup({
			history = true,
			region_check_events = "InsertEnter",
			delete_check_events = "TextChanged,InsertLeave",
		})
		require("luasnip.loaders.from_vscode").lazy_load() -- Allow formatting of snippets like vs-code
		luasnip.filetype_extend("flutter", { "flutter" }) -- Add flutter snippets

		cmp.setup({
			mapping = require("keymaps").cmp,
			cmp = {
				source_priority = {
					nvim_lsp = 1000,
					luasnip = 750,
					copilot = 600,
					path = 250,
					buffer = 500,
				},
			},
			window = {
				completion = cmp.config.window.bordered({ --border = "shadow",
					winhighlight = "FloatBorder:TelescopePromptBorder,Normal:Normal",
				}),
				documentation = cmp.config.window.bordered({
					winhighlight = "FloatBorder:TelescopePromptBorder,Normal:Normal",
				}),
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			sources = cmp.config.sources({
				{ name = "copilot" },
				{ name = 'path' },
				{ name = "luasnip" }, -- For luasnip users.
				{ name = "nvim_lua" },
				-- Dont suggest Text from nvm_lsp
				{
					name = "nvim_lsp",
					entry_filter = function(entry, ctx)
						return cmp.lsp.CompletionItemKind.Text ~= entry:get_kind()
					end,
				},
			}),
		})
	end
}
---------------------------------
-- Copilot
---------------------------------
M[#M + 1] = {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = { enabled = false, auto_trigger = true, },
			panel = { enabled = false },
		})
	end,
}

M[#M + 1] = {
	"zbirenbaum/copilot-cmp",
	dependencies = {
		"hrsh7th/nvim-cmp",
		"zbirenbaum/copilot.lua",
		"onsails/lspkind.nvim"
	},
	config = function()
		require("copilot_cmp").setup({
			event = { "InsertEnter", "LspAttach" },
			fix_pairs = true,
		})

		-- Make it look nice and work with CMP
		local cmp = require("cmp")

		-- Setup suggested by read me
		cmp.event:on("menu_opened", function()
			vim.b.copilot_suggestion_hidden = true
		end)
		cmp.event:on("menu_closed", function()
			vim.b.copilot_suggestion_hidden = false
		end)

		vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

		-- Fancy symbols
		local lspkind = require("lspkind")
		cmp.setup({
			formatting = {
				format = lspkind.cmp_format({
					symbol_map = { Copilot = "" },
					mode = "symbol", -- show only symbol annotations
					maxwidth = 150, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
					-- The function below will be called before any actual modifications from lspkind
					-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
					before = function(entry, vim_item)
						return vim_item
					end,
				}),
			},
		})
	end,
}

return M
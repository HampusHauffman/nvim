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
luasnip.filetype_extend("flutter", { "flutter" })  -- Add flutter snippets

cmp.setup({
	mapping = require("keymaps").cmp,
	cmp = {
		source_priority = {
			nvim_lsp = 1000,
			luasnip = 750,
			buffer = 500,
			path = 250,
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
		{ name = 'path' },
		{ name = "luasnip" }, -- For luasnip users.
		{ name = "nvim_lua" },
		-- Dont suggest Text from nvm_lsp
		{
			name = "nvim_lsp",
			entry_filter = function(entry, ctx)
				return require("cmp").lsp.CompletionItemKind.Text ~= entry:get_kind()
			end,
		},
	}),
})

-- Fancy symbols
local lspkind = require("lspkind")
cmp.setup({
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function(entry, vim_item)
				return vim_item
			end,
		}),
	},
})

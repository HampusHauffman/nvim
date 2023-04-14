-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
local luasnip = require("luasnip")
-- nvim-cmp setup
local cmp = require("cmp")

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
		-- Dont suggest Text from nvm_lsp
		{
			name = "nvim_lsp",
			entry_filter = function(entry, ctx)
				return require("cmp").lsp.CompletionItemKind.Text ~= entry:get_kind()
			end,
		},
		{ name = "luasnip" }, -- For luasnip users.
		{ name = "nvim_lua" },
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

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	view = {
		entries = { name = "wildmenu", separator = "  " },
	},
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	view = {
		entries = { name = "wildmenu", separator = "  " },
	},
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

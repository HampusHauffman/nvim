require("neodev").setup({})
local lspconfig = require("lspconfig")

require("mason").setup({
	ui = {
		border = "rounded",
		height = 0.8,
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})


vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
	vim.lsp.handlers.hover, {
		border = "rounded"
	}
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
	vim.lsp.handlers.signature_help, {
		border = "rounded"
	}
)
vim.diagnostic.config {
	float = { border = "rounded" },
}

require('lspconfig.ui.windows').default_options.border = 'rounded'

require("mason-lspconfig").setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({})
	end,
})

-- mason must be loaded before this
require("mason-null-ls").setup({
	automatic_setup = true,
	automatic_installation = true,
})

-- mason-null-ls must be loaded before this
require("null-ls").setup()

local cmp_nvim_lsp = require "cmp_nvim_lsp"

require("lspconfig").clangd.setup {
  on_attach = on_attach,
  capabilities = cmp_nvim_lsp.default_capabilities(),
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
}

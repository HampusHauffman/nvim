require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

local lspconfig = require("lspconfig")

 vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
       vim.lsp.handlers.hover, {
         -- Use a sharp border with `FloatBorder` highlights
         border = "rounded"
       }
     )

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

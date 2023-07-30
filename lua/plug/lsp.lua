local M = {
	{ 'mfussenegger/nvim-dap' },
	{ "fladson/vim-kitty" },
	{ "pantharshit00/vim-prisma" },

}

M[#M + 1] = {
	"folke/neodev.nvim",
	config = function()
		require("neodev").setup({})
	end
}

M[#M + 1] = {
	"neovim/nvim-lspconfig",
	config = function()
		require("lspconfig.ui.windows").default_options.border = 'rounded'

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
	end
}


M[#M + 1] = {
	"williamboman/mason.nvim",
	config = function()
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
	end
}

M[#M + 1] = {
	"williamboman/mason-lspconfig.nvim",
	config = function()
		require("mason-lspconfig").setup_handlers({
			function(server_name) -- default handler (optional)
				require("lspconfig")[server_name].setup({})
			end,
			["rust_analyzer"] = function()
				require("rust-tools").setup {}
			end,
		})
	end
}

M[#M + 1] = {
	"jose-elias-alvarez/null-ls.nvim",
	config = function()
		require("null-ls").setup()
	end
}


M[#M + 1] = {
	"jayp0521/mason-null-ls.nvim",
	config = function()
		require("mason-null-ls").setup({
			automatic_setup = true,
			automatic_installation = true,
		})
	end
}

M[#M + 1] = {
	'simrat39/rust-tools.nvim',
	config = function()
		local rt = require("rust-tools")
		rt.setup({
			server = {
				settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy"
						}
					}
				},
				on_attach = function()
				end,
			},
		})
		rt.inlay_hints.enable()
	end
}

M[#M + 1] = {
	"akinsho/flutter-tools.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		require("flutter-tools").setup({}) -- use defaults
	end,
}

M[#M + 1] = {
	"folke/trouble.nvim",
	dependencies = "kyazdani42/nvim-web-devicons",
	config = function()
		require("trouble").setup({})
	end,
}

M[#M + 1] = {
	"saecki/crates.nvim",
	version = 'v0.3.0',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		require('crates').setup()
	end,
}
return M

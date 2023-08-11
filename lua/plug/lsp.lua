local M = {
    { 'mfussenegger/nvim-dap' },
    { "fladson/vim-kitty" },
    { "pantharshit00/vim-prisma" },
    { "L3MON4D3/LuaSnip" },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    -- LSP Support
    { 'neovim/nvim-lspconfig' },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'hrsh7th/cmp-nvim-lsp',
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lua",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",

        },
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'dev-v3',
        config = function()
            -- Setup LSP
            local lsp = require('lsp-zero').preset({})
            lsp.setup()
            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end)

            require('mason').setup({})
            require('mason-lspconfig').setup({ handlers = { lsp.default_setup, }, })

            require("luasnip.loaders.from_vscode").lazy_load() -- Allow formatting of snippets like vs-code

            -- Setup CMP
            lsp.extend_cmp()
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            cmp.setup({
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },
                mapping = require("keymaps").cmp,
                window = {
                    completion = cmp.config.window.bordered({
                        winhighlight = "FloatBorder:FloatBorder,Normal:Normal", }),
                    documentation = cmp.config.window.bordered({
                        winhighlight = "FloatBorder:FloatBorder,Normal:Normal", }),
                },
                sources = cmp.config.sources({
                    { name = "copilot" },
                    { name = "nvim_lua" },
                    { name = 'nvim_lsp' },
                    { name = "luasnip" }, -- For luasnip users.
                    { name = 'path' },
                    { name = "crates" },
                }),
                formatting = {
                    fields = { 'kind', 'menu', 'abbr' },
                    format = lspkind.cmp_format({
                        symbol_map = { Copilot = "" },
                        mode = "symbol",
                        maxwidth = 150,
                    }),
                },
            })
        end
    },
}

M[#M + 1] = {
    "folke/neodev.nvim",
    config = function()
        require("neodev").setup({})
    end
}

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
    end,
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
                on_attach = function(_, bufnr)
                    vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
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
        require('crates').setup {
            null_ls = {
                enabled = true,
                name = "crates.nvim",
            },
        }
    end,
}
return M

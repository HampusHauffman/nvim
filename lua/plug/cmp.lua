local M = {
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
            "L3MON4D3/LuaSnip",
        },
        config = function()
            -- Setup CMP
            local cmp = require("cmp")
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )

            local lspkind = require("lspkind")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert,noselect',
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
    }
}

M[#M + 1] = {
    "L3MON4D3/LuaSnip",
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load() -- Allow formatting of snippets like vs-code
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
return M

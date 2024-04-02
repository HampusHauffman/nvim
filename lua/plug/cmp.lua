local M = { {
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

        'VonHeikemen/lsp-zero.nvim',

    },
    config = function()
        local lsp = require('lsp-zero').preset({})
        -- Setup CMP
        lsp.extend_cmp()
        local cmp = require("cmp")
        local lspkind = require("lspkind")
        cmp.setup({
            preselect = 'item',
            autocomplete = true,
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
},

}

return M

local M = {}
M[#M + 1] = {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function()
        --local keymaps = require "keymaps".treesitter
        ---@diagnostic disable-next-line: missing-fields
        require "nvim-treesitter.configs".setup {
            indent = {
                --enable = false
                enable = true
            },
            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            auto_install = true,

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<leader>v",
                    node_incremental = "<C-k>",
                    node_decremental = "<C-j>",
                },
            },

            highlight = {
                -- `false` will disable the whole extension
                enable = true,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },

            rainbow = {
                enable = true,
                -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                max_file_lines = nil, -- Do not enable for files with more than n lines, int
                -- colors = {}, -- table of hex strings
                -- termcolors = {} -- table of colour name strings
            }
        }
        local opt = vim.opt -- Set options (global/buffer/windows-scoped)
        opt.foldmethod = "expr"
        opt.foldexpr = "nvim_treesitter#foldexpr()"
    end
}

M[#M + 1] = {
    "nvim-treesitter/playground",
    config = function()
        require("nvim-treesitter.configs").setup({
            playground = {
                enable = true,
                disable = {},
                updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
                persist_queries = false, -- Whether the query persists across vim sessions
                keybindings = {
                    toggle_query_editor = "o",
                    toggle_hl_groups = "i",
                    toggle_injected_languages = "t",
                    toggle_anonymous_nodes = "a",
                    toggle_language_display = "I",
                    focus_language = "f",
                    unfocus_language = "F",
                    update = "R",
                    goto_node = "<cr>",
                    show_help = "?",
                },
            },
        })
    end,
}

return M

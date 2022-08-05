require("null-ls").setup({
    sources = {
        require("null-ls").builtins.completion.spell,
        require("null-ls").builtins.diagnostics.eslint,
        -- require("null-ls").builtins.diagnostics.luacheck,
        require("null-ls").builtins.diagnostics.ktlint,
        -- require("null-ls").builtins.formatter.dart_format,
        -- require("null-ls").builtins.formatting.stylua,
    },
})

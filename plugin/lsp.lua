require "mason".setup {
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
}

local lspconfig = require "lspconfig"

require "mason-lspconfig".setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require "lspconfig"[server_name].setup {}
    end,
    -- Next, you can provide targeted overrides for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    ["sumneko_lua"] = function()
        lspconfig.sumneko_lua.setup {
            settings = {
                Lua = {
                    format = {
                        enable = true,
                        -- Put format options here
                        -- NOTE: the value should be STRING!!
                        defaultConfig = {
                            quote_style = "double",
                            call_arg_parentheses = "unambiguous_remove_string_only",
                        }
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        }
    end,
}

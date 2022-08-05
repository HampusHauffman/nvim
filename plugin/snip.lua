local luasnip = require "luasnip"
luasnip.filetype_extend("flutter", { "flutter" }) -- Add flutter snippets
require("luasnip.loaders.from_vscode").lazy_load()



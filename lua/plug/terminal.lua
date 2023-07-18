local M = {}
M[#M + 1] = {
    "akinsho/toggleterm.nvim",
    version = "v2.*",
    config = function()
        require("toggleterm").setup({
            insert_mappings = true, -- whether or not the open mapping applies in insert mode
            terminal_mappings = true,
            persist_size = true,
            shade_terminals = false,
            height = 10,
            direction = "horizontal",
            float_opts = {
                border = "curved",
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
            },
            highlights = {
                Normal = {
                    link = "Menu"
                },
                NormalFloat = {
                    link = "Menu"
                },
                FloatBorder = {
                    link = "Border"
                }
            }
        })
    end
}

return M

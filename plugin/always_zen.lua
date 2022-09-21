local M = {}

local getLeftBufWinId = function()
    return tonumber(vim.api.nvim_exec([[
                echo bufwinid(bufnr("left_buf"))
            ]],
        true))
end

local function singleWinOpen()
    return (vim.api.nvim_list_wins()[2] == nil)
end

local function set_pad_options()
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.cursorline = false
    vim.wo.signcolumn = "no"
    vim.bo.buflisted = false -- Make sure the buf is not listed
    vim.bo.modifiable = false -- Make sure it cant be altered and prevent close
    vim.wo.statusline = " "
    vim.wo.fillchars = "stlnc: "
end

local closeZen = function()
    vim.api.nvim_win_close(getLeftBufWinId(), true)
    vim.api.nvim_del_augroup_by_name "AlwaysZen"
end

local function auCmdForZenBuf()

    vim.api.nvim_create_augroup("AlwaysZen", {
        clear = false
    })

    vim.api.nvim_create_autocmd({ "BufEnter" }, {
        pattern = { "*" },
        group = "AlwaysZen",
        callback = closeZen -- Or myvimfun
    })

end

local addPadding = function()
    if (singleWinOpen()) then
        local window_width = vim.api.nvim_win_get_width(0)
        local window_id = vim.api.nvim_get_current_win()

        -- Open a new window on the left side with name left_buf
        vim.cmd "topleft vnew left_buf"

        set_pad_options()

        -- Go back to middle window
        vim.api.nvim_set_current_win(window_id)

        -- Resize current window to a good size
        vim.cmd("vertical resize " .. window_width - 120 / 2)

        auCmdForZenBuf()


    end

end

vim.api.nvim_create_augroup("CheckSingleWindow", {
    clear = false
})

return M

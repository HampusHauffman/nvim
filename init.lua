-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Leader key
vim.g.mapleader = " "
--vim.cmd("colorscheme dracula-soft")
require("opt")
require("keymaps")
require("aucmd")

---@class LazyConfig
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
    {
      "MunifTanjim/nui.nvim",
      lazy = false,
    },
    {
      "Mofiqul/dracula.nvim",
      priority = 1000,
      lazy = false,
      config = function()
        require("dracula").setup({
          theme = "dracula-soft",
          colors = {
            bg = "#000000",
            black = "#000000",
            visual = "#3E4452",
          },
          show_end_of_buffer = true, -- default false
          transparent_bg = true, -- default false
          lualine_bg_color = "#000000", -- default nil
          italic_comment = true, -- default false
          overrides = {},
        })
        vim.cmd("colorscheme dracula-soft")
        require("hl")
      end,
    },
    {
      "HampusHauffman/block.nvim",
      dev = true,
      percent = 1.2,
      priority = 1000,
      opts = {
        percent = 1.4,
        depth = 4,
        bg = "#101010",
        automatic = false,
        colors = { "#00ff00", "#ff0000", "#0000ff" },
      },
    },
  },
  install = { colorscheme = { "dracula-soft" } },
  checker = {
    notify = true, -- get a notification when new updates are found
  },
  ---@diagnostic disable-next-line: assign-type-mismatch
  dev = { path = "~/Documents" },
  ui = {
    border = "rounded",
  },
})

-- Activate manual lsp
--vim.lsp.enable("gdshader-lsp")
vim.lsp.enable("kotlin-ls")

-- Global variable for command line content
_G.lualine_cmdline = nil

---@type string[]
local message_errors =
  { "emsg", "echoerr", "lua_error", "rpc_error", "shell_err" }

local use_ext_messages = vim.notify ~= vim._notify
-- Hook into cmdline UI events
vim.ui_attach(
  vim.api.nvim_create_namespace("nui_cmdline"),
  { ext_cmdline = true, ext_messages = true },
  ---@diagnostic disable-next-line: redundant-parameter
  function(event, ...)
    if event == "cmdline_show" then
      local content, _, firstc, prompt = ...
      local line = (firstc or "") .. (prompt or "")
      for _, chunk in ipairs(content) do
        line = line .. chunk[2]
      end
      _G.lualine_cmdline = line
      require("lualine").refresh()
    elseif event == "cmdline_hide" then
      _G.lualine_cmdline = nil
      require("lualine").refresh()
    elseif event == "msg_show" then
      local kind, content = ...
      local message = ""
      for _, chunk in ipairs(content) do
        message = message .. chunk[2]
      end

      if kind == "return_prompt" then
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes("<CR>", true, false, true),
          "n",
          true
        )
        return
      end

      local level = "info"
      for _, value in pairs(message_errors) do
        if kind == value then
          level = "error"
        end
      end

      vim.schedule(function()
        vim.notify(
          "Kind: " .. kind .. ", Message: " .. vim.trim(message),
          level
        )
      end)
    end
  end
)

local keymaps = require("keymaps.dap")

---@type LazyPluginSpec[]
local M = {}

M[#M + 1] = {
  "rcarriga/nvim-dap-ui",
  dependencies = { "nvim-neotest/nvim-nio" },
  keys = keymaps.ui,
  opts = {},
  config = function(_, opts)
    local dap = require("dap")
    local dapui = require("dapui")
    local function open()
      dapui.open()
    end
    local function close()
      dapui.close()
    end

    dapui.setup(opts)
    dap.listeners.after.event_initialized["dapui_config"] = open
    dap.listeners.before.event_terminated["dapui_config"] = close
    dap.listeners.before.event_exited["dapui_config"] = close
  end,
}

M[#M + 1] = {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    { "theHamsta/nvim-dap-virtual-text", opts = {} },
  },
  keys = keymaps.keys,
  init = function()
    vim.fn.sign_define("DapBreakpoint", {
      text = "●",
      texthl = "DiagnosticError",
      linehl = "",
      numhl = "",
    })
  end,
  config = function()
    require("dap").adapters.godot = {
      type = "server",
      host = "127.0.0.1",
      port = 6007,
    }
  end,
}

return M

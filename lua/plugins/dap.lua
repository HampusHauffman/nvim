local M = {}

function M.setup()
  local dap = require("dap")
  local dapui = require("dapui")

  dapui.setup({})
  require("nvim-dap-virtual-text").setup({})

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end

  vim.fn.sign_define("DapBreakpoint", {
    text = "●",
    texthl = "DiagnosticError",
    linehl = "",
    numhl = "",
  })

  dap.adapters.godot = {
    type = "server",
    host = "127.0.0.1",
    port = 6007,
  }

  local keymaps = require("keymaps")
  local dap_keys = require("keymaps.dap")
  keymaps.set(dap_keys.ui)
  keymaps.set(dap_keys.keys)
end

return M

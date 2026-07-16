local M = {}

local function call(module, method)
  return function()
    require(module)[method]()
  end
end

---@type LazyKeysSpec[]
M.ui = {
  { "<leader>du", call("dapui", "toggle"), desc = "Dap UI" },
  {
    "<leader>de",
    call("dapui", "eval"),
    desc = "Eval",
    mode = { "n", "x" },
  },
}

---@type LazyKeysSpec[]
M.keys = {
  {
    "<leader>dB",
    function()
      require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end,
    desc = "Breakpoint Condition",
  },
  {
    "<leader>dr",
    function()
      require("dap").repl.toggle()
    end,
    desc = "Toggle REPL",
  },
  {
    "<leader>dw",
    function()
      require("dap.ui.widgets").hover()
    end,
    desc = "Widgets",
  },
  {
    "<leader>db",
    call("dap", "toggle_breakpoint"),
    desc = "Toggle Breakpoint",
  },
  { "<leader>dc", call("dap", "continue"), desc = "Run/Continue" },
  { "<leader>dC", call("dap", "run_to_cursor"), desc = "Run to Cursor" },
  { "<leader>dg", call("dap", "goto_"), desc = "Go to Line (No Execute)" },
  { "<leader>di", call("dap", "step_into"), desc = "Step Into" },
  { "<leader>dj", call("dap", "down"), desc = "Down" },
  { "<leader>dk", call("dap", "up"), desc = "Up" },
  { "<leader>dl", call("dap", "run_last"), desc = "Run Last" },
  { "<leader>do", call("dap", "step_out"), desc = "Step Out" },
  { "<leader>dO", call("dap", "step_over"), desc = "Step Over" },
  { "<leader>dP", call("dap", "pause"), desc = "Pause" },
  { "<leader>ds", call("dap", "session"), desc = "Session" },
  { "<leader>dt", call("dap", "terminate"), desc = "Terminate" },
}

return M

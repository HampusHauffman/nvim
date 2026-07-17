local M = {}

---@class CommandToComplete
---@field complete string

---@alias CommandAction string|function|CommandToComplete
---@type [string, CommandAction][]
M.commands = {
  { "Update plugins", vim.pack.update },
  { "Check plugins", "checkhealth vim.pack" },
  { "Check health", { complete = "checkhealth " } },
  { "Restart NeoVim", "restart" },
  { "DiffView", "restart" },
}

function M.open()
  Snacks.picker.select(M.commands, {
    prompt = "Commands",
    format_item = function(item)
      return item[1]
    end,
  }, function(item)
    if not item then
      return
    end

    local action = item[2]
    if type(action) == "string" then
      vim.cmd(action)
    elseif type(action) == "function" then
      action()
    else
      assert(type(action.complete) == "string", "invalid command action")
      vim.api.nvim_feedkeys(":" .. action.complete, "n", false)
    end
  end)
end

return M

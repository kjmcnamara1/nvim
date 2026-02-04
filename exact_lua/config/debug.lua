if profile() ~= "default" then
  return
end

vim.pack.add({
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/rcarriga/nvim-dap-ui",
  -- "https://github.com/igorlfs/nvim-dap-view", -- minimal dap-ui
  "https://github.com/jay-babu/mason-nvim-dap.nvim",
})

require("mason-nvim-dap").setup()

local dap = require('dap')
local dapui = require('dapui')

dapui.setup()


wk.add({
  { "<a-b>",      "<cmd>DapToggleBreakpoint<cr>", desc = "Debug: Toggle breakpoint" },
  { "<leader>du", dapui.toggle,                   desc = "Debug: Toggle UI" },
  { "<leader>dc", dap.continue,                   desc = "Debug: Continue" },
  { "<leader>di", dap.step_into,                  desc = "Debug: Step Into" },
  { "<leader>dn", dap.step_over,                  desc = "Debug: Step Next" },
  { "<leader>do", dap.step_out,                   desc = "Debug: Step Out" },
})

vim.api.nvim_set_hl(0, 'DapBreak', { link = 'DapBreakpoint' })
vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
local breakpoint_icons = {
  Breakpoint = '',
  BreakpointCondition = '',
  BreakpointRejected = '',
  LogPoint = '',
  Stopped = ''
}

for type, icon in pairs(breakpoint_icons) do
  local tp = 'Dap' .. type
  local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
  vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
end

dap.listeners.before.attach.dapui_config = dapui.open
dap.listeners.before.launch.dapui_config = dapui.open
dap.listeners.before.event_terminated.dapui_config = dapui.close
dap.listeners.before.event_exited.dapui_config = dapui.close

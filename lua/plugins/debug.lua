return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "jay-babu/mason-nvim-dap.nvim",
      "Weissle/persistent-breakpoints.nvim",
    },
    cond = profile() == "default",
    cmd = { "DapToggleBreakpoint", "DapContinue", "DapStepOver", "DapStepInto", "DapStepOut" },
    keys = {
      { "<a-b>", "<cmd>DapToggleBreakpoint<cr>", desc = "Debug: Toggle Breakpoint" },
      {
        "<a-s-b>",
        function()
          vim.ui.input({ prompt = "Log Message: ", completion = vim.bo.filetype }, function(msg)
            require('dap').set_breakpoint(nil, nil, msg)
          end)
        end,
        desc = "Debug: Set Logpoint"
      },
      { "<F5>",  "<cmd>DapContinue<cr>",         desc = "Debug: Continue" },
      { "<F6>",  "<cmd>DapTerminate<cr>",        desc = "Debug: Terminate" },
      { "<F7>",  "<cmd>DapStepOver<cr>",         desc = "Debug: Step Next" },
      { "<F8>",  "<cmd>DapStepInto<cr>",         desc = "Debug: Step Into" },
      { "<F9>",  "<cmd>DapStepOut<cr>",          desc = "Debug: Step Out" },
    },
    init = function()
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
    end,
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      dap.listeners.before.attach.dapui_config = dapui.open
      dap.listeners.before.launch.dapui_config = dapui.open
      -- dap.listeners.before.event_terminated.dapui_config = dapui.close
      dap.listeners.before.event_exited.dapui_config = dapui.close
    end
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason-org/mason.nvim",
    cond = profile() == "default",
    lazy = true,
    opts = {},
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "nvim-neotest/nvim-nio",
    },
    cond = profile() == "default",
    keys = {
      { "<leader>du", function() require('dapui').toggle() end, desc = "Debug: Toggle UI" },
    },
    opts = {},
  },

  {
    "Weissle/persistent-breakpoints.nvim",
    cond = profile() == "default",
    opts = {
      load_breakpoints_event = "BufReadPost",
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistenceSavePost",
        group = vim.api.nvim_create_augroup("PersistentBreakpoints", { clear = true }),
        desc = "Save persistent breakpoints",
        callback = function()
          require("persistent-breakpoints.api").store_breakpoints()
        end
      })
    end
  },

  {
    "mfussenegger/nvim-dap-python",
    cond = profile() == "default",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "linux-cultist/venv-selector.nvim",
    },
    config = function()
      require("dap-python").setup("uv")
    end,
  },

  {
    "jbyuki/one-small-step-for-vimkind",
    ft = "lua",
  },

}

return {

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
      "rouge8/neotest-rust",
    },
    cond = profile() == "default",
    -- event = "VeryLazy",
    keys = {
      { "<leader>tn", function() require("neotest").run.run() end,                     desc = "Tests: Run Nearest" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,   desc = "Tests: Run Current File" },
      { "<leader>ta", function() require("neotest").run.run({ suite = true }) end,     desc = "Tests: Run All" },
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Tests: Debug Nearest" },
      { "<leader>ts", function() require("neotest").run.stop() end,                    desc = "Tests: Stop Nearest" },
      { "<leader>tA", function() require("neotest").run.attach() end,                  desc = "Tests: Attach to Nearest" },
      { "<leader>tw", function() require("neotest").watch.toggle() end,                desc = "Tests: Toggle Watch" },
      { "<leader>tt", function() require("neotest").summary.toggle() end,              desc = "Tests: Toggle Summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Tests: Open Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end,         desc = "Tests: Toggle Output Panel" },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            -- dap = { justMyCode = false },
            args = { "--log-level", "DEBUG" },
            python = function() return require("venv-selector").python() end,
          }),
          require("neotest-rust"),
        },
      })
    end
  },

}

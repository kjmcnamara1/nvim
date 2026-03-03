return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  cond = profile() == "default",
  event = "VeryLazy",
  opts = {
    options = {
      globalstatus = true,
      disabled_filetypes = { statusline = { "snacks_dashboard" } },
    },
    sections = {
      lualine_b = {
        "branch",
        {
          "diff",
          symbols = {
            added = " ",
            modified = " ",
            removed = " "
          }
        },
        "diagnostics"
      },
      lualine_c = {
        {
          function()
            return "󱉭 " .. vim.fs.basename(vim.uv.cwd())
          end,
          color = "Special"
        },
        {
          "filename",
          newfile_status = true,
          path = 1,
          symbols = {
            modified = " ",
            readonly = " ",
            unnamed = "No Name  ",
            newfile = "New  "
          }
        }
      },
      lualine_y = {
        "venv-selector",
        "progress",
      },
    }
  },
}

if profile() ~= "default" then
  return
end

vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

require("lualine").setup({
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
  }
})

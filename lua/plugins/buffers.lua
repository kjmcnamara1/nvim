return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "echasnovski/mini.icons",
    "folke/snacks.nvim",
    -- { "backdround/tabscope.nvim", config = true },
  },
  cond = profile() == "default",
  event = "VeryLazy",
  keys = {
    { "<leader>'", "<c-^>",                        desc = "Buffer: Alternate" },
    { "<a-p>",     "<cmd>BufferLineTogglePin<cr>", desc = "Buffer: Pin" },
    { "<a-s-l>",   "<cmd>BufferLineMoveNext<cr>",  desc = "Buffer: Move Right" },
    { "<a-s-h>",   "<cmd>BufferLineMovePrev<cr>",  desc = "Buffer: Move Left" },
    { "<a-l>",     "<cmd>BufferLineCycleNext<cr>", desc = "Buffer: Next" },
    { "<a-h>",     "<cmd>BufferLineCyclePrev<cr>", desc = "Buffer: Prev" },
  },
  opts = function()
    return {
      options = {
        tab_size = 15,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        close_command = Snacks.bufdelete.delete,
        right_mouse_command = Snacks.bufdelete.delete,
        groups = {
          options = {
            toggle_hidden_on_enter = true,
          },
          items = {
            {
              name = "Docs",
              highlight = { underline = true },
              auto_close = true,
              priority = 2,
              matcher = function(buf)
                return buf.name:match('%.md')
                    -- or buf.name:match('%.txt')
                    or buf.name == "LICENSE"
                    or buf.name == "mkdocs.yml"
              end,
              separator = {
                style = require('bufferline.groups').separator.pill
              },
            },
            {
              name = "Tests",
              highlight = { sp = vim.api.nvim_get_hl(0, { name = "Error" }).fg },
              auto_close = true,
              priority = 3,
              icon = " ",
              matcher = function(buf)
                return buf.name:match('test_')
              end,
            },
          }
        }
      }
    }
  end,
}

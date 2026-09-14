return {
  {
    "smart-splits-nvim/smart-splits.nvim",
    lazy = false,
    cond = profile() == "default",
    build = function(plugin)
      if vim.fn.executable("herdr") == 0 then return end
      vim.cmd("!herdr plugin link " .. plugin.dir .. " && herdr server reload-config")
    end,
    keys = function()
      local splits = require("smart-splits")
      return {
        -- { "<c-w><c-w>", splits.move_cursor_previous, desc = "Window: Focus Previous" },
        { "<c-h>",   splits.move_cursor_left,  desc = "Window: Focus Left",  mode = { "n", "x", "t" } },
        { "<c-j>",   splits.move_cursor_down,  desc = "Window: Focus Down",  mode = { "n", "x", "t" } },
        { "<c-k>",   splits.move_cursor_up,    desc = "Window: Focus Up",    mode = { "n", "x", "t" } },
        { "<c-l>",   splits.move_cursor_right, desc = "Window: Focus Right", mode = { "n", "x", "t" } },
        -- { "<c-a-h>", splits.resize_left,       desc = "Window: Resize Left",  mode = { "n", "x", "t" } },
        -- { "<c-a-j>", splits.resize_down,       desc = "Window: Resize Down",  mode = { "n", "x", "t" } },
        -- { "<c-a-k>", splits.resize_up,         desc = "Window: Resize Up",    mode = { "n", "x", "t" } },
        -- { "<c-a-l>", splits.resize_right,      desc = "Window: Resize Right", mode = { "n", "x", "t" } },
        { "<c-s-h>", splits.swap_buf_left,     desc = "Window: Swap Left",   mode = { "n", "x", "t" } },
        { "<c-s-j>", splits.swap_buf_down,     desc = "Window: Swap Down",   mode = { "n", "x", "t" } },
        { "<c-s-k>", splits.swap_buf_up,       desc = "Window: Swap Up",     mode = { "n", "x", "t" } },
        { "<c-s-l>", splits.swap_buf_right,    desc = "Window: Swap Right",  mode = { "n", "x", "t" } },
      }
    end,
    opts = {
      at_edge = "stop",
      cursor_follows_swapped_bufs = true,
    },
  },

  {
    "pogyomo/submode.nvim",
    lazy = false,
    cond = profile() == "default",
    config = function()
      local splits = require("smart-splits")
      require("submode").create("WinResize", {
        mode = "n",
        enter = "<c-w>r",
        leave = { "<esc>", "q", "<c-c>" },
        hook = {
          on_enter = function()
            vim.notify("Window Resize Mode")
          end,
        },
        default = function(register)
          register("h", splits.resize_left, { desc = "Window: Resize Left" })
          register("j", splits.resize_down, { desc = "Window: Resize Down" })
          register("k", splits.resize_up, { desc = "Window: Resize Up" })
          register("l", splits.resize_right, { desc = "Window: Resize Right" })
        end
      })
    end
  },

}

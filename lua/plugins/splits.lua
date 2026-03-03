return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  cond = profile() == "default",
  keys = function()
    local splits = require("smart-splits")
    return {
      -- { "<c-w><c-w>", splits.move_cursor_previous, desc = "Window: Focus Previous" },
      { "<c-h>",   splits.move_cursor_left,  desc = "Window: Focus Left",    mode = { "n", "x", "t" } },
      { "<c-j>",   splits.move_cursor_down,  desc = "Window: Focus Down",    mode = { "n", "x", "t" } },
      { "<c-k>",   splits.move_cursor_up,    desc = "Window: Focus Up",      mode = { "n", "x", "t" } },
      { "<c-l>",   splits.move_cursor_right, desc = "Window: Focus Right",   mode = { "n", "x", "t" } },
      { "<c-a-h>", splits.resize_left,       desc = "Window: Resize Left",   mode = { "n", "x", "t" } },
      { "<c-a-j>", splits.resize_down,       desc = "Window: Resize Down",   mode = { "n", "x", "t" } },
      { "<c-a-k>", splits.resize_up,         desc = "Window: Resize Up",     mode = { "n", "x", "t" } },
      { "<c-a-l>", splits.resize_right,      desc = "Window: Resize Right",  mode = { "n", "x", "t" } },
      { "<c-s-h>", splits.swap_buf_left,     desc = "Window: Swap Left",     mode = { "n", "x", "t" } },
      { "<c-s-j>", splits.swap_buf_down,     desc = "Window: Swap Down",     mode = { "n", "x", "t" } },
      { "<c-s-k>", splits.swap_buf_up,       desc = "Window: Swap Up",       mode = { "n", "x", "t" } },
      { "<c-s-l>", splits.swap_buf_right,    desc = "Window: Swap Right",    mode = { "n", "x", "t" } },
    }
  end,
  opts = { cursor_follows_swapped_bufs = true },
}

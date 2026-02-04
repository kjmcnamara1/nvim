if profile() ~= "default" then
  return
end

vim.pack.add({ "https://github.com/mrjones2014/smart-splits.nvim" })

local splits = require("smart-splits")

splits.setup({ cursor_follows_swapped_bufs = true })

wk.add({
  { "<leader>w", proxy = "<c-w>", group = "Windows",     mode = { "n", "x" }, expand = require("which-key.extras").expand.win },
  { "<c-c>",     "<c-w>q",        desc = "Window: Close" },
  {
    mode = { "n", "x", "t" },
    -- { "<c-w><c-w>", splits.move_cursor_previous, desc = "Window: Focus Previous" },
    { "<c-h>",   splits.move_cursor_left,  desc = "Window: Focus Left" },
    { "<c-j>",   splits.move_cursor_down,  desc = "Window: Focus Down" },
    { "<c-k>",   splits.move_cursor_up,    desc = "Window: Focus Up" },
    { "<c-l>",   splits.move_cursor_right, desc = "Window: Focus Right" },
    { "<c-a-h>", splits.resize_left,       desc = "Window: Resize Left" },
    { "<c-a-j>", splits.resize_down,       desc = "Window: Resize Down" },
    { "<c-a-k>", splits.resize_up,         desc = "Window: Resize Up" },
    { "<c-a-l>", splits.resize_right,      desc = "Window: Resize Right" },
    { "<c-s-h>", splits.swap_buf_left,     desc = "Window: Swap Left" },
    { "<c-s-j>", splits.swap_buf_down,     desc = "Window: Swap Down" },
    { "<c-s-k>", splits.swap_buf_up,       desc = "Window: Swap Up" },
    { "<c-s-l>", splits.swap_buf_right,    desc = "Window: Swap Right" },
  },
})

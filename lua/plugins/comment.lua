-- TODO: add keymap for double comment/deprecated

return {
  "numToStr/Comment.nvim",
  keys = {
    { "gc", desc = "Line comment",  mode = { "n", "x" } },
    { "gb", desc = "Block comment", mode = { "n", "x" } },
  },
  opts = {
    -- sticky = false,
    ignore = "^%s*$", -- Ignore blank lines
  }
}

-- TODO: Add pattern for todo checkbox
-- TODO: Change highlight for TODO to yellow
-- BUG: Highlighting is not working for checkboxes

-- require("todo-comments.config").keywords
-- require("todo-comments.config").hl_regex

return {
  "folke/todo-comments.nvim",
  cond = profile() == "default",
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Todo: Next" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Todo: Previous" },
  },
  opts = {
    highlight = {
      -- pattern = { [[.*<(KEYWORDS)\s*:]], [[.*%[ %]\s*:]] },
      -- pattern = { [[.*<(KEYWORDS)\s*:|%[.%]:]] },
    },
    keywords = {
      TODO = { icon = " ", color = "todo" },
      DONE = { icon = " ", color = "info" },
      BUG = { icon = " ", color = "error", alt = { "FIXME", "FIX", "FIXIT", "ISSUE" } },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = " ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
    colors = {
      todo = { "@comment.todo" },
      test = { colors.dark_blue },
    },

  },
}

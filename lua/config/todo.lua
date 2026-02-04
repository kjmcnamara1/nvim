-- [ ]: Add pattern for todo checkbox
-- [ ]: Change highlight for TODO to yellow

if profile() ~= "default" then
  return
end

vim.pack.add({ "https://github.com/folke/todo-comments.nvim" })

require("todo-comments").setup({
  keywords = {
    TODO = { color = "todo", alt = { "[ ]" } },
    DONE = { color = "info", alt = { "[x]", "[X]" } },
  },
  colors = {
    todo = { "@comment.todo", "#FFFF00" },
  },

})
wk.add({
  { "]t", require("todo-comments").jump_next, desc = "Next todo comment" },
  { "[t", require("todo-comments").jump_prev, desc = "Previous Todo Comment" },
})

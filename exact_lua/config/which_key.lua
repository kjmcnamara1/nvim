vim.pack.add({ "https://github.com/folke/which-key.nvim" })

_G.wk = require("which-key")

_G.insert_line_above = function()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  for _ = 1, vim.v.count1 do
    vim.api.nvim_buf_set_lines(0, line - 1, line - 1, true, { "" })
  end
end

_G.insert_line_below = function()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  for _ = 1, vim.v.count1 do
    vim.api.nvim_buf_set_lines(0, line, line, true, { "" })
  end
end

wk.setup({ preset = "helix" })

wk.add({
  { "u",       "u",                      desc = "Undo",                          mode = { "n" } },
  { "U",       "<c-r>",                  desc = "Redo",                          mode = { "n" } },
  { "M",       "m",                      desc = "Mark",                          mode = { "n" } },
  { "m",       "<nop>",                  desc = "Remove default `mark` mapping", mode = { "n", "x" },     hidden = true },
  { "<a-s-j>", "J",                      desc = "Join Lines",                    mode = { 'n', 'x' } },
  { "%",       ":normal! ggVG<cr>",      desc = "Select Entire Buffer",          mode = { "n", "x", "o" } },
  { "gx",      ":sil !open <cWORD><cr>", desc = "Open link under cursor" },

  {
    mode = { "n", "i", "x" },
    { "<s-f1>", wk.show,                                    desc = "Keymaps: Global" },
    { "<f1>",   function() wk.show({ global = false }) end, desc = "Keymaps: Local" },
  },

  {
    mode = { "i" },
    { "<c-i>", "<tab>",  desc = "Literal Tab" },
    { "<c-v>", "<c-r>+", desc = "Paste from system clipboard" },
  },

  {
    mode = { "x" },
    { "<", "<gv", desc = "Indent: Left" },
    { ">", ">gv", desc = "Indent: Right" },
    { "=", "=gv", desc = "Indent: Auto" },
  },

  {
    "<a-o>",
    function()
      vim.go.operatorfunc = "v:lua.insert_line_below"
      return "g@l"
    end,
    desc = "Insert line below",
    expr = true,
  },
  {
    "<a-O>",
    function()
      vim.go.operatorfunc = "v:lua.insert_line_above"
      return "g@l"
    end,
    desc = "Insert line above",
    expr = true,
  },
  {
    mode = { "x" },
    "<a-o>",
    function()
      vim.go.operatorfunc = "v:lua.insert_line_below"
      return "g@gv"
    end,
    desc = "Insert line below",
    expr = true,
  },
  {
    mode = { "x" },
    "<a-O>",
    function()
      vim.go.operatorfunc = "v:lua.insert_line_above"
      return "g@gv"
    end,
    desc = "Insert line above",
    expr = true,
  },
})

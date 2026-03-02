local function n_insert_line_below()
  vim.go.operatorfunc = "v:lua.insert_line_below"
  return "g@l"
end

local function n_insert_line_above()
  vim.go.operatorfunc = "v:lua.insert_line_above"
  return "g@l"
end

local function v_insert_line_below()
  vim.go.operatorfunc = "v:lua.insert_line_below"
  return "g@gv"
end

local function v_insert_line_above()
  vim.go.operatorfunc = "v:lua.insert_line_above"
  return "g@gv"
end

local function remove_mark()
  local start_line, end_line

  -- Check if we are in a visual mode
  local mode = vim.api.nvim_get_mode().mode
  if mode:match("[vV]") then
    -- Get visual range
    start_line = vim.fn.line("v")
    end_line = vim.fn.line(".")
    -- Sort them in case the user selected upwards
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end
  else
    -- Normal mode: just the current line
    start_line = vim.fn.line(".")
    end_line = start_line
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local marks = vim.fn.getmarklist(bufnr)
  vim.list_extend(marks, vim.fn.getmarklist())

  for _, m in ipairs(marks) do
    local mark_line = m.pos[2]
    local mark_name = m.mark:sub(2)

    if mark_line >= start_line and mark_line <= end_line then
      -- Only delete lettered marks
      if mark_name:match("%l") then
        vim.api.nvim_buf_del_mark(bufnr, mark_name)
      elseif mark_name:match("%u") then
        vim.api.nvim_del_mark(mark_name)
      end
    end
  end
end

return {
  "folke/which-key.nvim",
  dependencies = {
    "echasnovski/mini.icons",
  },
  init = function()
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
  end,
  opts_extend = { "spec" },
  opts = {
    preset = "helix",
    spec = {
      -- Lazy
      { "<leader>L", "<cmd>Lazy<cr>",     desc = "Lazy Plugin Manager" },

      -- Undo
      { "u",         "u",                 desc = "Undo",                          mode = { "n" } },
      { "U",         "<c-r>",             desc = "Redo",                          mode = { "n" } },

      -- Marks
      { "M",         "m",                 desc = "Mark: Set",                     mode = { "n" } },
      { "m",         "<nop>",             desc = "Remove default `mark` mapping", mode = { "n", "x" }, hidden = true },
      { "<a-s-m>",   remove_mark,         desc = "Mark: Remove",                  mode = { "n", "x" } },
      { "'",         "`",                 desc = "Mark: Jump to line",            mode = { "n", "x" } },
      { "`",         "'",                 desc = "Mark: Jump to position",        mode = { "n", "x" } },
      { "<a-s-j>",   "J",                 desc = "Join Lines",                    mode = { 'n', 'x' } },

      -- Insert line
      { "<a-o>",     n_insert_line_below, desc = "Insert line below",             mode = { "n" },      expr = true },
      { "<a-O>",     n_insert_line_above, desc = "Insert line above",             mode = { "n" },      expr = true },
      { "<a-o>",     v_insert_line_below, desc = "Insert line below",             mode = { "x" },      expr = true },
      { "<a-O>",     v_insert_line_above, desc = "Insert line above",             mode = { "x" },      expr = true },

      -- Keymap Help
      {
        mode = { "n", "i", "x" },
        { "<s-f1>", function() require("which-key").show() end,                   desc = "Keymaps: Global" },
        { "<f1>",   function() require("which-key").show({ global = false }) end, desc = "Keymaps: Local" },
      },

      -- Insert Mode
      {
        mode = { "i" },
        { "<c-i>", "<tab>",  desc = "Literal Tab" },
        { "<c-v>", "<c-r>+", desc = "Paste from system clipboard" },
      },

      -- Indent
      {
        mode = { "x" },
        { "<", "<gv", desc = "Indent: Left" },
        { ">", ">gv", desc = "Indent: Right" },
        { "=", "=gv", desc = "Indent: Auto" },
      },

    }
  }

}

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
    "nvim-mini/mini.icons",
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
      {
        "<leader>w",
        proxy = "<c-w>",
        group = "Windows",
        mode = { "n", "x" },
        expand = function()
          require("which-key.extras").expand.win()
        end
      },
      { "<leader>u", group = "UI" },
      { "<leader>g", group = "Git" },
      { "<leader>gh", group = "GitHub" },
      { "<leader>d", group = "Debug" },
      { "<leader>a", group = "AI Agent",         mode = { "n", "x" } },
      { "<leader>c", group = "Code",           mode = { "n", "x" } },
      { "<leader>h", group = "Hunks (Git)",      mode = { "n", "x" } },
      { "<leader>s", group = "Pick/Select",    mode = { "n", "x" } },
      { "<leader>L", "<cmd>Lazy<cr>",          desc = "Lazy Plugin Manager" },
      { "<c-c>",     "<c-w>q",                 desc = "Window: Close" },
      { "u",         "u",                      desc = "Undo" },
      { "U",         "<c-r>",                  desc = "Redo" },
      { "gx",        ":sil !open <cWORD><cr>", desc = "Open link under cursor" },
      { "%",         ":normal! ggVG<cr>",      desc = "Select Entire Buffer",          mode = { "n", "x", "o" } },

      -- Marks
      { "M",         "m",                      desc = "Mark: Set",                     mode = { "n" } },
      { "m",         "<nop>",                  desc = "Remove default `mark` mapping", mode = { "n", "x" },     hidden = true },
      { "<a-s-m>",   remove_mark,              desc = "Mark: Remove",                  mode = { "n", "x" } },
      { "'",         "`",                      desc = "Mark: Jump to line",            mode = { "n", "x" } },
      { "`",         "'",                      desc = "Mark: Jump to position",        mode = { "n", "x" } },
      { "<a-s-j>",   "J",                      desc = "Join Lines",                    mode = { 'n', 'x' } },

      -- Insert line
      { "<a-o>",     n_insert_line_below,      desc = "Insert line below",             mode = { "n" },          expr = true },
      { "<a-O>",     n_insert_line_above,      desc = "Insert line above",             mode = { "n" },          expr = true },
      { "<a-o>",     v_insert_line_below,      desc = "Insert line below",             mode = { "x" },          expr = true },
      { "<a-O>",     v_insert_line_above,      desc = "Insert line above",             mode = { "x" },          expr = true },

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

      {
        mode = { "i", "t", "c" },
        -- This forces a redraw of the cursor whereas simple <left> doesn't
        { "<a-h>", function() vim.api.nvim_feedkeys(vim.keycode("<left>"), "i", true) end,  desc = "Cursor: Left",  remap = true },
        { "<a-j>", function() vim.api.nvim_feedkeys(vim.keycode("<down>"), "i", true) end,  desc = "Cursor: Down",  remap = true },
        { "<a-k>", function() vim.api.nvim_feedkeys(vim.keycode("<up>"), "i", true) end,    desc = "Cursor: Up",    remap = true },
        { "<a-l>", function() vim.api.nvim_feedkeys(vim.keycode("<right>"), "i", true) end, desc = "Cursor: Right", remap = true },
      },
      { "j",     [[v:count == 0 ? 'gj' : 'j']],     desc = "Cursor: Down by visible line", expr = true,   mode = { "n", "x" } },
      { "k",     [[v:count == 0 ? 'gk' : 'k']],     desc = "Cursor: Up by visible line",   expr = true,   mode = { "n", "x" } },
      { "<a-j>", "<cmd>m .+1<cr>==",                desc = "Line: Move down",              mode = { "n" } },
      { "<a-k>", "<cmd>m .-2<cr>==",                desc = "Line: Move up",                mode = { "n" } },
      { "<a-j>", ":m '>+1<cr>gv=gv",                desc = "Line: Move down",              mode = { "x" } },
      { "<a-k>", ":m '<-2<cr>gv=gv",                desc = "Line: Move up",                mode = { "x" } },

      { "m",     group = "match",                   mode = { "n", "x" } },
      { "mm",    "<Plug>(MatchitNormalForward)",    desc = "Match Pair",                   mode = { "n" } },
      { "mm",    "<Plug>(MatchitVisualForward)",    desc = "Match Pair",                   mode = { "x" } },
      { "mm",    "<Plug>(MatchitOperationForward)", desc = "Match Pair",                   mode = { "o" } },
      { "<esc>", "<cmd>noh<cr><esc>",               desc = "Clear hlsearch",               mode = { "i" } },
    }
  }

}

pack_add({
  "https://github.com/xiyaowong/fast-cursor-move.nvim",
  "https://github.com/chrisgrieser/nvim-spider",
  "https://github.com/jake-stewart/multicursor.nvim",
  "https://github.com/nvim-mini/mini.extra",
  "https://github.com/nvim-mini/mini.ai",
  "https://github.com/nvim-mini/mini.surround",
})

require("spider").setup({ consistentOperatorPending = true })
local mc = require("multicursor-nvim")
mc.setup()
vim.api.nvim_set_hl(0, "MultiCursorCursor", { fg = "#7b8290", reverse = true })

-- doesn't interfere with dial.nvim
mc.addKeymapLayer(function(layerSet)
  layerSet({ "n", "x" }, "g<c-a>", mc.sequenceIncrement, { desc = "MultiCursor: Sequence increment" })
  layerSet({ "n", "x" }, "g<c-x>", mc.sequenceDecrement, { desc = "MultiCursor: Sequence decrement" })
end)

wk.add({
  {
    mode = { "i", "t", "c" },
    { "<a-h>", "<left>",  desc = "Cursor: Left",  remap = true },
    { "<a-l>", "<right>", desc = "Cursor: Right", remap = true },
    { "<a-j>", "<down>",  desc = "Cursor: Down",  remap = true },
    { "<a-k>", "<up>",    desc = "Cursor: Up",    remap = true },
  },

  {
    mode = { "n", "o", "x" },
    { "w", "<cmd>lua require('spider').motion('w')<cr>", desc = "Spider: w" },
    { "e", "<cmd>lua require('spider').motion('e')<cr>", desc = "Spider: e" },
    { "b", "<cmd>lua require('spider').motion('b')<cr>", desc = "Spider: b" },
  },

  {
    mode = { "n", "x" },
    { "m",       group = "match" },
    { "j",       [[v:count == 0 ? 'gj' : 'j']],                 desc = "Cursor: Down by visible line",                       expr = true },
    { "k",       [[v:count == 0 ? 'gk' : 'k']],                 desc = "Cursor: Up by visible line",                         expr = true },
    { "<a-j>",   "<cmd>m .+1<cr>==",                            desc = "Line: Move down",                                    mode = { "n" } },
    { "<a-k>",   "<cmd>m .-2<cr>==",                            desc = "Line: Move up",                                      mode = { "n" } },
    { "<a-j>",   ":m '>+1<cr>gv=gv",                            desc = "Line: Move down",                                    mode = { "x" } },
    { "<a-k>",   ":m '<-2<cr>gv=gv",                            desc = "Line: Move up",                                      mode = { "x" } },

    { "<tab>",   mc.toggleCursor,                               desc = 'MultiCursor: Add/remove main cursor' },
    { "<a-,>",   mc.deleteCursor,                               desc = 'MultiCursor: Delete main cursor' },
    { ",",       mc.clearCursors,                               desc = 'MultiCursor: Keep only main cursor' },
    -- { "mcd",     mc.duplicateCursors,                  desc = 'MultiCursor: Duplicate cursors' },
    -- { "mcw",     function() mc.addCursor('w') end,     desc = 'MultiCursor: Next word' },
    -- { "mcW",     function() mc.addCursor('W') end,     desc = 'MultiCursor: Next Word' },
    -- { "mcb",     function() mc.addCursor('b') end,     desc = 'MultiCursor: back word' },
    -- { "mcB",     function() mc.addCursor('B') end,     desc = 'MultiCursor: Back word' },
    { "J",       function() mc.lineAddCursor(1) end,            desc = 'MultiCursor: Add cursor below' },
    { "K",       function() mc.lineAddCursor(-1) end,           desc = 'MultiCursor: Add cursor above' },
    { "*",       function() mc.matchAddCursor(1) end,           desc = 'MultiCursor: Add cursor to next cword/sel' },
    { "#",       function() mc.matchAddCursor(-1) end,          desc = 'MultiCursor: Add cursor to previous cword/sel' },
    { "<m-s-8>", function() mc.matchSkipCursor(1) end,          desc = 'MultiCursor: Next cword/sel' },
    { "<m-s-3>", function() mc.matchSkipCursor(-1) end,         desc = 'MultiCursor: Previous cword/sel' },
    -- { "n",       function() mc.searchSkipCursor(1) end,         desc = 'MultiCursor: Next search result',                    mode = { "n" } },
    -- { "N",       function() mc.searchSkipCursor(-1) end,        desc = 'MultiCursor: Previous search result',                mode = { "n" } },
    -- { "n",       function() mc.searchAddCursor(1) end,          desc = 'MultiCursor: Add cursor to next search result',      mode = { "x" } },
    -- { "N",       function() mc.searchAddCursor(-1) end,         desc = 'MultiCursor: Add cursor to previous search result',  mode = { "x" } },
    { ")",       mc.nextCursor,                                 desc = 'MultiCursor: Move main cursor to next selection' },
    { "(",       mc.prevCursor,                                 desc = 'MultiCursor: Move main cursor to previous selection' },
    { "<c-i>",   mc.jumpForward,                                desc = 'MultiCursor: Jump forwards' },
    { "<c-o>",   mc.jumpBackward,                               desc = 'MultiCursor: Jump backwards' },
    { "&",       mc.alignCursors,                               desc = 'MultiCursor: Align cursors' },
    { "mc",      function() mc.addCursorOperator("CURSOR") end, desc = "MultiCursor: Add cursor operator" },
  },

  {
    mode = { "x" },
    { ";",       function() mc.feedkeys("<esc>", { remap = false, keycodes = true }) end, desc = 'MultiCursor: Exit visual mode' },
    { "I",       mc.insertVisual,                                                         desc = 'MultiCursor: Insert before cursors' },
    { "A",       mc.appendVisual,                                                         desc = 'MultiCursor: Append after cursors' },
    { "M",       mc.matchCursors,                                                         desc = 'MultiCursor: Match cursors' },
    { "S",       mc.splitCursors,                                                         desc = 'MultiCursor: Split cursors' },
    { "<a-s-0>", function() mc.swapCursors(1) end,                                        desc = 'MultiCursor: Swap main selection forwards' },   -- alt + )
    { "<a-s-9>", function() mc.swapCursors(-1) end,                                       desc = 'MultiCursor: Swap main selection backwards' },  -- alt + (
    { "<M-S-]>", function() mc.transposeCursors(1) end,                                   desc = 'MultiCursor: Transpose selections forwards' },  -- alt + }
    { "<M-S-[>", function() mc.transposeCursors(-1) end,                                  desc = 'MultiCursor: Transpose selections backwards' }, --  alt + {
    {
      "<a-s>",
      function()
        mc.action(function(ctx)
          vim.iter(ctx:getCursors()):map(function(cursor)
            return cursor:splitVisualLines()
          end):flatten():each(function(cursor)
            local _, end_pos = cursor:getVisual()
            cursor:setVisualAnchor(end_pos):feedkeys("o")
          end)
        end)
      end,
      desc = "MultiCursor: Split selection on newlines"
    },
    {
      "<a-=>",
      function()
        mc.action(function(ctx)
          ctx:forEachCursor(function(cursor)
            local text = table.concat(cursor:getVisualLines(), "\n")
            local result = require("util.execute_text").execute_text(text)
            cursor:setVisualLines(
              vim.split(result, "\n", { plain = true, trimempty = true })
            )
          end)
        end)
      end,
      desc = "Multijcursor: Evaluate visual selection(s)",
    },

  },
  { "<c-leftmouse>",   mc.handleMouse,                    desc = 'MultiCursor: Add/remove cursor' },
  { "<c-leftdrag>",    mc.handleMouseDrag,                desc = 'MultiCursor: Add/remove cursor' },
  { "<c-leftrelease>", mc.handleMouseRelease,             desc = 'MultiCursor: Add/remove cursor' },
  { "gv",              mc.restoreCursors,                 desc = "MultiCursor: Restore cursors" },
  { "mm",              "<Plug>(MatchitNormalForward)",    desc = "Match Pair",                    mode = { "n" } },
  { "mm",              "<Plug>(MatchitVisualForward)",    desc = "Match Pair",                    mode = { "x" } },
  { "mm",              "<Plug>(MatchitOperationForward)", desc = "Match Pair",                    mode = { "o" } },
  { "<esc>",           "<cmd>noh<cr><esc>",               desc = "Clear hlsearch",                mode = { "i" } },
  {
    "<esc>",
    function()
      local floating = vim.api.nvim_win_get_config(0).relative ~= ""
      if not mc.cursorsEnabled() then
        -- Cursors paused
        mc.enableCursors()
      elseif mc.hasCursors() then
        -- Cursors active
        mc.clearCursors()
      elseif profile() == "minimal" then
        -- Single cursor, minimal profile (kitty scrollback, active-window-info, etc.)
        vim.cmd("qall!")
      elseif not vim.bo.modifiable then
        -- Single cursor, non-modifiable window
        -- (LspInfo, ConformInfo, help, hover, etc.)
        vim.cmd.close()
      elseif not floating then
        -- Single cursor, modifiable, fixed window
        vim.cmd.fclose()
      else
        -- Single cursor, modifiable, floating window
        -- (Snacks scratch/zen/zoom, etc.)
        -- vim.api.nvim_feedkeys(vim.keycode("<esc>"), "n", true)
      end
      vim.cmd.noh()
    end,
    desc = "Super Escape",
  },
})

local ai = require("mini.ai")
local gen_ai_spec = require('mini.extra').gen_ai_spec
require("mini.ai").setup({
  n_lines = 500,
  -- mappings = {
  --   goto_left = "[",
  --   goto_right = "]",
  -- },
  custom_textobjects = {
    -- o = ai.gen_spec.treesitter({ -- code block
    --   a = { "@block.outer", "@conditional.outer", "@loop.outer" },
    --   i = { "@block.inner", "@conditional.inner", "@loop.inner" },
    -- }),
    A = ai.gen_spec.treesitter({ a = "@assignment.outer", i = "@assignment.inner" }), -- assignment
    m = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),     -- method / function definition
    c = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }),       -- comment
    C = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),           -- class
    Q = { "([\"'])%1%1.-%1%1%1", "^...().-()...$" },                                  -- balanced python triple quote
    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },               -- tags
    e = {                                                                             -- Word with case
      { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
      "^().*()$",
    },
    i = gen_ai_spec.indent(),
    d = gen_ai_spec.diagnostic(),
    l = gen_ai_spec.line(),                                    -- use ll/nl - same behavior for last and next
    N = gen_ai_spec.number(),
    B = gen_ai_spec.buffer(),                                  -- entire buffer
    f = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
    F = ai.gen_spec.function_call(),                           -- with dot in function name
  },
})

require("mini.surround").setup({
  n_lines = 500,
  mappings = {
    add = "ms",
    delete = "md",
    find = "mf",
    find_left = "mF",
    highlight = "mh",
    replace = "mr",
    update_n_lines = "mn",
  }
})

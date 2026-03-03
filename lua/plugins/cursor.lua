return {

  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    keys = function()
      local mc = require("multicursor-nvim")

      return {
        { "<tab>",   mc.toggleCursor,                                                         desc = 'MultiCursor: Add/remove main cursor',                 mode = { "n", "x" } },
        { "<a-,>",   mc.deleteCursor,                                                         desc = 'MultiCursor: Delete main cursor',                     mode = { "n", "x" } },
        { ",",       mc.clearCursors,                                                         desc = 'MultiCursor: Keep only main cursor',                  mode = { "n", "x" } },
        -- { "mcd",     mc.duplicateCursors,                  desc = 'MultiCursor: Duplicate cursors' ,mode = { "n", "x" }},
        -- { "mcw",     function() mc.addCursor('w') end,     desc = 'MultiCursor: Next word' ,mode = { "n", "x" }},
        -- { "mcW",     function() mc.addCursor('W') end,     desc = 'MultiCursor: Next Word' ,mode = { "n", "x" }},
        -- { "mcb",     function() mc.addCursor('b') end,     desc = 'MultiCursor: back word' ,mode = { "n", "x" }},
        -- { "mcB",     function() mc.addCursor('B') end,     desc = 'MultiCursor: Back word' ,mode = { "n", "x" }},
        { "J",       function() mc.lineAddCursor(1) end,                                      desc = 'MultiCursor: Add cursor below',                       mode = { "n", "x" } },
        { "K",       function() mc.lineAddCursor(-1) end,                                     desc = 'MultiCursor: Add cursor above',                       mode = { "n", "x" } },
        { "*",       function() mc.matchAddCursor(1) end,                                     desc = 'MultiCursor: Add cursor to next cword/sel',           mode = { "n", "x" } },
        { "#",       function() mc.matchAddCursor(-1) end,                                    desc = 'MultiCursor: Add cursor to previous cword/sel',       mode = { "n", "x" } },
        { "<m-s-8>", function() mc.matchSkipCursor(1) end,                                    desc = 'MultiCursor: Next cword/sel',                         mode = { "n", "x" } },
        { "<m-s-3>", function() mc.matchSkipCursor(-1) end,                                   desc = 'MultiCursor: Previous cword/sel',                     mode = { "n", "x" } },
        -- { "n",       function() mc.searchSkipCursor(1) end,         desc = 'MultiCursor: Next search result',                    mode = { "n" } },
        -- { "N",       function() mc.searchSkipCursor(-1) end,        desc = 'MultiCursor: Previous search result',                mode = { "n" } },
        -- { "n",       function() mc.searchAddCursor(1) end,          desc = 'MultiCursor: Add cursor to next search result',      mode = { "x" } },
        -- { "N",       function() mc.searchAddCursor(-1) end,         desc = 'MultiCursor: Add cursor to previous search result',  mode = { "x" } },
        { ")",       mc.nextCursor,                                                           desc = 'MultiCursor: Move main cursor to next selection',     mode = { "n", "x" } },
        { "(",       mc.prevCursor,                                                           desc = 'MultiCursor: Move main cursor to previous selection', mode = { "n", "x" } },
        { "<c-i>",   mc.jumpForward,                                                          desc = 'MultiCursor: Jump forwards',                          mode = { "n", "x" } },
        { "<c-o>",   mc.jumpBackward,                                                         desc = 'MultiCursor: Jump backwards',                         mode = { "n", "x" } },
        { "&",       mc.alignCursors,                                                         desc = 'MultiCursor: Align cursors',                          mode = { "n", "x" } },
        { "mc",      function() mc.addCursorOperator("CURSOR") end,                           desc = "MultiCursor: Add cursor operator",                    mode = { "n", "x" } },

        { ";",       function() mc.feedkeys("<esc>", { remap = false, keycodes = true }) end, desc = 'MultiCursor: Exit visual mode',                       mode = { "x" } },
        { "I",       mc.insertVisual,                                                         desc = 'MultiCursor: Insert before cursors',                  mode = { "x" } },
        { "A",       mc.appendVisual,                                                         desc = 'MultiCursor: Append after cursors',                   mode = { "x" } },
        { "M",       mc.matchCursors,                                                         desc = 'MultiCursor: Match cursors',                          mode = { "x" } },
        { "S",       mc.splitCursors,                                                         desc = 'MultiCursor: Split cursors',                          mode = { "x" } },
        { "<a-s-0>", function() mc.swapCursors(1) end,                                        desc = 'MultiCursor: Swap main selection forwards',           mode = { "x" } }, -- alt + )
        { "<a-s-9>", function() mc.swapCursors(-1) end,                                       desc = 'MultiCursor: Swap main selection backwards',          mode = { "x" } }, -- alt + (
        { "<M-S-]>", function() mc.transposeCursors(1) end,                                   desc = 'MultiCursor: Transpose selections forwards',          mode = { "x" } }, -- alt + }
        { "<M-S-[>", function() mc.transposeCursors(-1) end,                                  desc = 'MultiCursor: Transpose selections backwards',         mode = { "x" } }, --  alt + {
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
          desc = "MultiCursor: Split selection on newlines",
          mode = { "x" }
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
          desc = "MultiCursor: Evaluate visual selection(s)",
          mode = { "x" }
        },

        { "<c-leftmouse>",   mc.handleMouse,        desc = 'MultiCursor: Add/remove cursor' },
        { "<c-leftdrag>",    mc.handleMouseDrag,    desc = 'MultiCursor: Add/remove cursor' },
        { "<c-leftrelease>", mc.handleMouseRelease, desc = 'MultiCursor: Add/remove cursor' },
        { "gV",              mc.restoreCursors,     desc = "MultiCursor: Restore cursors" },
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
            elseif not floating and profile() ~= "vscode" then
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
      }
    end,
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()
      vim.api.nvim_set_hl(0, "MultiCursorCursor", { fg = "#7b8290", reverse = true })
      -- doesn't interfere with dial.nvim
      mc.addKeymapLayer(function(layerSet)
        layerSet({ "n", "x" }, "g<c-a>", mc.sequenceIncrement, { desc = "MultiCursor: Sequence increment" })
        layerSet({ "n", "x" }, "g<c-x>", mc.sequenceDecrement, { desc = "MultiCursor: Sequence decrement" })
      end)
    end,
  },

  {
    "echasnovski/mini.ai",
    dependencies = 'echasnovski/mini.extra',
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      local gen_ai_spec = require('mini.extra').gen_ai_spec
      return {
        n_lines = 500,
        -- mappings = {
        --   goto_left = "[",
        --   goto_right = "]",
        -- },
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
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
      }
    end
  },

  {
    "echasnovski/mini.surround",
    keys = {
      { "ms", desc = "Add surrounding",                     mode = { "n", "v" } },
      { "md", desc = "Delete surrounding" },
      { "mf", desc = "Find right surrounding" },
      { "mF", desc = "Find left surrounding" },
      { "mh", desc = "Highlight surrounding" },
      { "mr", desc = "Replace surrounding" },
      { "mn", desc = "Update `MiniSurround.config.n_lines`" },
    },
    opts = {
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
    }
  },

}

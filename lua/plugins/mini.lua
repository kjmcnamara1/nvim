return {
  {
    "echasnovski/mini.basics",
    event = "VeryLazy",
    opts = {
      extra_ui = true,
      windows = true,
      move_with_alt = true,
    },
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = true,
  },
  {
    "echasnovski/mini.bracketed",
    event = "VeryLazy",
    config = true,
  },
  {
    "echasnovski/mini.cursorword",
    event = "VeryLazy",
    config = true,
  },
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    config = true,
  },

  -- Better text-objects
  {
    -- TODO: Add text object for comments 'gc'
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        },
      }
    end,
  },
  {
    "echasnovski/mini.indentscope",
    event = "VeryLazy",
    opts = {
      -- symbol = "▏",
      symbol = "│",
      draw = {
        animation = nil, --require("mini.indentscope").get_animation.none(),
      },
      options = {
        -- indent_at_cursor = false,
        try_as_border = true,
      },
    },
    init = function()
      -- Automatically disable mini.indentscope for certain filetypes
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- Better than mini.comment
  -- mini.comment does not have block comments (gb, gbc)
  -- mini.comment does not have gcA, gco, gcO
  -- missing 'gc' textobject from mini.comment for ops like 'dgc'
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      opts = {
        enable_autocmd = false,
      },
    },
    opts = {
      ignore = "^%s*$",
      pre_hook = function()
        require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      end,
    },
    keys = {
      {
        "<c-_>",
        function()
          require("Comment.api").toggle.linewise.current()
        end,
        mode = "i",
        desc = "Toggle comment",
      },
      { "gc", mode = { "n", "x" } },
      { "gb", mode = { "n", "x" } },
    },
  },
  {
    "echasnovski/mini.comment",
    enabled = false,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      opts = {
        enable_autocmd = false,
      },
    },
    opts = {
      options = {
        ignore_blank_line = true,
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
    keys = {
      "gcc",
      { "gc", mode = { "n", "x" } },
      {
        "<c-_>", -- 'Ctrl-/'
        function()
          local line_num = vim.api.nvim_win_get_cursor(0)[1]
          require("mini.comment").toggle_lines(line_num, line_num)
        end,
        mode = "i",
        desc = "Toggle comment line",
      },
    },
  },
}

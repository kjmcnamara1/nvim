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
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>x",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Delete Buffer",
      },
    },
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = true,
  },
  {
    "echasnovski/mini.surround",
    config = true,
    -- opts = {
    --   mappings = {
    --     add = "sa", -- Add surrounding in Normal and Visual modes
    --     delete = "sd", -- Delete surrounding
    --     find = "sf", -- Find surrounding (to the right)
    --     find_left = "sF", -- Find surrounding (to the left)
    --     highlight = "sh", -- Highlight surrounding
    --     replace = "sr", -- Replace surrounding
    --     update_n_lines = "gsn", -- Update `n_lines`
    --   },
    -- },
  },
  -- {
  --   "JoosepAlviste/nvim-ts-context-commentstring",
  --   opts = {
  --     enable_autocmd = false,
  --   },
  -- },
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      opts = {
        enable_autocmd = false,
      },
    },
    config = true,
    -- TODO: Get tree-sitter context commentstring working
    -- opts = {
    --   pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    -- },
  },
  {
    "echasnovski/mini.comment",
    enabled = false,
    -- event = "VeryLazy",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      opts = {
        enable_autocmd = false,
      },
    },
    opts = {
      options = {
        ignore_blank_lines = true,
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
    -- TODO: add c-/ to keybinds
    keys = {
      { "gc", mode = { "n", "x" } },
      "gcc",
      { "gb", mode = { "n", "x" } },
      "gbc",
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

  -- Better text-objects
  {
    "echasnovski/mini.ai",
    -- keys = {
    --   { "a", mode = { "x", "o" } },
    --   { "i", mode = { "x", "o" } },
    -- },
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
    "echasnovski/mini.bracketed",
    config = true,
  },
  {
    "echasnovski/mini.cursorword",
    config = true,
  },
  {
    "echasnovski/mini.indentscope",
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
}

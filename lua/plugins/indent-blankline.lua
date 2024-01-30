return {
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      indent = {
        -- char = "│",
        char = "",
        tab_char = "│",
      },
      whitespace = {
        highlight = {
          "CursorColumn",
          "Whitespace",
        },
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
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
      },
    },
    main = "ibl",
    -- dependencies = {
    --   {
    --     "luochen1990/rainbow",
    --     config = function()
    --       vim.g.rainbow_active = 1
    --     end,
    --   },
    --   {
    --     "HiPhish/rainbow-delimiters.nvim",
    --     -- opts={},
    --   },
    -- },
  },
}

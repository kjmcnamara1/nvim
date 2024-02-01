return {
  {
    "rmehri01/onenord.nvim",
    name = "onenord",
    event = 'VimEnter',
    -- lazy = false,
    priority = 1000,
    opts = {
      -- fade_nc = true,
      styles = {
        comments = "italic",
        keywords = "bold",
      }
    },
  },
  {
    "shaunsingh/nord.nvim",
    name = "nord",
    lazy = true,
    --priority = 1000,
  },
  {
    "olimorris/onedarkpro.nvim",
    name = "onedarkpro",
    lazy = true,
    --priority = 1000, -- Ensure it loads first
  },
  {
    "navarasu/onedark.nvim",
    name = "onedark",
    lazy = true,
    --priority = 1000,
  },
  {
    "neanias/everforest-nvim",
    name = "everforest",
    lazy = true,
    version = false,
    --priority = 1000, -- make sure to load this before all the other start plugins
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    --priority = 1000,
    opts = {
      transparent_background = true,
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
}

return {

  {
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
    cond = profile() == "default",
    lazy = true,
    config = function(_, opts)
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip").setup(opts)
    end,
  },

  {
    "danymat/neogen",
    dependencies = "L3MON4D3/LuaSnip",
    cond = profile() == "default",
    cmd = "Neogen",
    keys = {
      { "<leader>cn", function() require("neogen").generate() end, desc = "Generate Annotations (Neogen)" },
    },
    opts = { snippet_engine = "luasnip" },
  },

  {
    "supermaven-inc/supermaven-nvim",
    cond = profile() == "default",
    event = "InsertEnter",
    opts = {
      keymaps = {
        accept_suggestion = "<a-s-l>",
        clear_suggestion = "<c-j>",
        accept_word = "<c-l>",
      }
    },
  },

  {
    "saghen/blink.cmp",
    dependencies = "L3MON4D3/LuaSnip",
    cond = profile() == "default",
    version = "*",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
      keymap = {
        preset = "super-tab",
        ["<up>"] = { "fallback" },
        ["<down>"] = { "fallback" },
      },
      appearance = { nerd_font_variant = "mono" },
      snippets = { preset = "luasnip" },
      signature = { enabled = true },
      cmdline = {
        enabled = true,
        keymap = { preset = "inherit" },
        completion = { menu = { auto_show = true } },
      },
      completion = {
        ghost_text = { enabled = false },
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
        menu = { draw = { treesitter = { "lsp", "path", "snippets" } } },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = {
          lua = { inherit_defaults = true, "lazydev" },
        },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority
            score_offset = 100,
          },
          snippets = {
            opts = {
              use_label_description = true,
            }
          }
        },
      }
    },
  },

}

if profile() ~= "default" then
  return
end

pack_add({
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/danymat/neogen",
  "https://github.com/supermaven-inc/supermaven-nvim",
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
})

wk.add({
  { "<leader>cn", function() require("neogen").generate() end, desc = "Generate Annotations (Neogen)" },
})

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").setup()

require("neogen").setup({ snippet_engine = "luasnip" })

require("supermaven-nvim").setup({
  keymaps = {
    accept_suggestion = "<a-s-l>",
    clear_suggestion = "<c-j>",
    accept_word = "<c-l>",
  }
})

require("blink.cmp").setup({
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
})

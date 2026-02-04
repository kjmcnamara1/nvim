if profile() ~= "default" then
  return
end

vim.pack.add({
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
  keymap = { preset = "super-tab" },
  appearance = { nerd_font_variant = "mono" },
  snippets = { preset = "luasnip" },
  signature = { enabled = true },
  completion = {
    ghost_text = { enabled = true },
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
    menu = { draw = { treesitter = { "lsp" } } },
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
    },
  }
})

if profile() ~= "default" then
  return
end

-- [ ]: Configure code folding

pack_add({
  "https://github.com/ThePrimeagen/refactoring.nvim",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
  "https://github.com/rachartier/tiny-code-action.nvim",
  "https://github.com/saecki/live-rename.nvim",
  "https://github.com/j-hui/fidget.nvim",
  "https://github.com/stevearc/conform.nvim",
})

wk.add({
  mode = { "n", "x" },
  { "g.",          require("tiny-code-action").code_action, desc = "LSP: Code Action" },
  { "grn",         require("live-rename").rename,           desc = "LSP: Rename" },
  { "<leader>k",   vim.lsp.buf.hover,                       desc = "LSP: Hover" },
  { "<leader>cil", "<cmd>checkhealth vim.lsp<cr>",          desc = "Info: LSP" },
  { "<leader>cic", "<cmd>ConformInfo<cr>",                  desc = "Info: Conform" },
  { '<leader>cf',  require('conform').format,               desc = "LSP: Format" },
  { "<leader>cm",  "<cmd>Mason<cr>",                        desc = "Mason" },
})

vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  -- jump = { float = true },
  signs = {
    text = { " ", " ", " ", "󰠠 " },
    numhl = {
      "DiagnosticSignError",
      "DiagnosticSignWarn",
      "DiagnosticSignInfo",
      "DiagnosticSignHint",
    },
  },
})

-- Use undercurls for diagnostics instead of flat underline
-- for _, d in ipairs({ "Error", "Warning", "Information", "Hint" }) do
--   local hl = "LspDiagnosticsUnderline" .. d
--   local sp = vim.api.nvim_get_hl(0, { name = hl }).sp
--   vim.api.nvim_set_hl(0, hl, { undercurl = true, sp = sp })
-- end

require("tiny-inline-diagnostic").setup({
  options = {
    -- show_source = {
    --   enabled = true,
    --   if_many = true,
    -- },
    multilines = {
      enabled = true,
    },
    use_icons_from_diagnostic = true,
  },
})

require("tiny-code-action").setup({
  backend = "delta",
  picker = "snacks",
  -- backend = "difftastic",
  -- picker = {
  --   "buffer",
  --   opts = {
  --     hotkeys = true,
  --     hotkeys_mode = "text_based",
  --     auto_preview = true,
  --   }
  -- }
})

require("live-rename").setup({ hl = { current = "IncSearch" } })

require('refactoring').setup()
require("fidget").setup()
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  auto_update = true,
  run_on_start = true,
  ensure_installed = {
    "bashls",
    "cssls",
    "fish_lsp",
    "hyprls",
    "jinja_lsp",
    "jsonls",
    "lua_ls",
    "marksman",
    "nixfmt",
    "prettierd",
    "basedpyright",
    "ruff",
    "debugpy",
    "shfmt",
    "taplo",
  }
})

require("conform").setup({
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
  default_format_opts = {
    lsp_format = "prefer",
    async = true,
  },
})

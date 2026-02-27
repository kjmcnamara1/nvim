if profile() ~= "default" then
  return
end

-- TODO: Configure code folding

pack_add({
  "https://github.com/ThePrimeagen/refactoring.nvim",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/chrisgrieser/nvim-origami",
  "https://github.com/nvimtools/none-ls.nvim",
  "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
  "https://github.com/rachartier/tiny-code-action.nvim",
  "https://github.com/saecki/live-rename.nvim",
  "https://github.com/j-hui/fidget.nvim",
  "https://github.com/stevearc/conform.nvim",
})

wk.add({
  mode = { "n", "x" },
  { "g.",          require("tiny-code-action").code_action,                  desc = "LSP: Code Action" },
  { "grn",         require("live-rename").rename,                            desc = "LSP: Rename" },
  -- { "<leader>k",   vim.lsp.buf.hover,                       desc = "LSP: Hover" },
  { "<leader>k",   function() vim.lsp.buf.hover({ border = "rounded" }) end, desc = "LSP: Hover" },
  { "<leader>cil", "<cmd>checkhealth vim.lsp<cr>",                           desc = "Info: LSP" },
  { "<leader>cic", "<cmd>ConformInfo<cr>",                                   desc = "Info: Conform" },
  { "<leader>cin", "<cmd>NullLsInfo<cr>",                                    desc = "Info: Null-Ls",   buffer = 0 },
  { '<leader>cf',  require('conform').format,                                desc = "LSP: Format" },
  { "<leader>cm",  "<cmd>Mason<cr>",                                         desc = "Mason" },
})

-- Turn off inlay hints in insert mode
local hint_group = vim.api.nvim_create_augroup("InlayHintsSmartToggle", { clear = true })
local hints_were_enabled = false

vim.api.nvim_create_autocmd("InsertEnter", {
  group = hint_group,
  callback = function()
    hints_were_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
    -- dd(hints_were_enabled)
    if hints_were_enabled then
      vim.lsp.inlay_hint.enable(false, { bufnr = 0 })
    end
  end
})
vim.api.nvim_create_autocmd("InsertLeave", {
  group = hint_group,
  callback = function()
    -- dd(hints_were_enabled)
    if hints_were_enabled then
      vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
    end
  end
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
  picker = {
    "snacks",
    opts = {
      layout = "code_action",
      focus = "list",
    },
  },
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
    -- Common / Web
    "prettierd",
    "cssls",
    "jsonls",
    "taplo",
    "marksman",
    "yamlls",
    "gh_actions_ls",

    -- Uncommon
    "hyprls",

    -- Neovim
    "lua_ls",
    "ts_query_ls",

    -- Shell
    "bashls",
    "shfmt",
    "fish_lsp",

    -- Python
    "basedpyright",
    "ruff",
    "debugpy",
    "jinja_lsp",

    -- Nix
    "nil_ls",
    "nixfmt",

    -- Rust
    "rust_analyzer",
    "codelldb",
  }
})

local nls = require("null-ls")
nls.setup({
  sources = {
    nls.builtins.hover.printenv,
    nls.builtins.diagnostics.fish,
  }
})

require("origami").setup({
  foldKeymaps = {
    scrollLeftOnCaret = true,
  }
})

-- vim.lsp.config('*', {
--   on_attach = function(client, bufnr)
--     if client and client:supports_method("textDocument/foldingRange") then
--       vim.wo.foldmethod = "expr"
--       vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
--       -- vim.wo.foldtext = "v:lua.vim.lsp.foldtext()"
--     end
--   end
-- })

require("conform").setup({
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
  default_format_opts = {
    lsp_format = "prefer",
    async = true,
  },
  formatters = {
    shfmt = {
      append_args = { "-i", "2", "-bn", "-ci", "-sr", "-kp" },
    },
  },
  formatters_by_ft = {
    sh = { "shfmt" },
    zsh = { "shfmt" },
    json = { "prettierd" },
    jsonc = { "prettierd" },
    yaml = { "prettierd" },
    nix = { "nixfmt" },
    xonsh = { "ruff" },
    fish = { "fish_indent" },
    markdown = { "prettierd" },
    rust = { "rustfmt" },
  }
})

vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"

-- Automatically clear the conform log on startup
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("ConformLogCleanup", { clear = true }),
  callback = function()
    local log_path = vim.fn.stdpath("state") .. "/conform.log"
    local f = io.open(log_path, "w")
    if f then
      f:write("")
      f:close()
    end
  end,
})

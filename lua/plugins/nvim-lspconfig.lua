local map = require("config").map_keys
local augroup = require("config").augroup

require("neodev").setup({
  library = {
    plugins = {
      "nvim-dap-ui",
    },
    types = true,
  }
})

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Add folding capabilities for ufo plugin
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- Add rounded borders to hover and signature popups
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

-- Customize diagnostics
vim.diagnostic.config({
  signs = {
    text = { "", "", "", "" },
    numhl = {
      "DiagnosticSignError",
      "DiagnosticSignWarn",
      "DiagnosticSignInfo",
      "DiagnosticSignHint",
    }
  },
  virtual_text = {
    source = "always",
    spacing = 4,
    prefix = function(diagnostic)
      local signs = { " ", " ", " ", "󰠠 " }
      return signs[diagnostic.severity] or "■"
    end,
  },
  float = {
    border = "rounded",
  },
  severity_sort = true,
})

require("mason-lspconfig").setup_handlers({
  function(ls)
    require("lspconfig")[ls].setup({
      capabilities = capabilities,
      handlers = handlers,
    })
  end,
  lua_ls = function()
    require("lspconfig").lua_ls.setup({
      capabilities = capabilities,
      handlers = handlers,
      settings = { -- custom settings for lua
        Lua = {
          -- use double quotes
          format = {
            defaultConfig = {
              quote_style = "double",
            },
          },
          -- make the language server recognize 'vim' global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Format file on save",
  group = augroup("lsp_format"),
  callback = function()
    vim.lsp.buf.format()
  end
})
--
-- Configure border for LspInfo ui
require("lspconfig.ui.windows").default_options.border = "rounded"

map("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover", buffer = 0 })
map("n", "<c-k>", vim.lsp.buf.signature_help, { desc = "LSP Signature Documentation", buffer = 0, mode = "i" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP Declaration", buffer = 0 })
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action", buffer = 0 })
map({ "n", "v" }, "<leader>cf", vim.lsp.buf.format, { desc = "LSP Format", buffer = 0 })
map("n", "<leader>ci", "<cmd>LspInfo<cr>", { desc = "LSP Info", buffer = 0 })
map("n", "<leader>df", vim.diagnostic.open_float, { desc = "LSP Open Diagnostics", buffer = 0 })
map("n", "]d", vim.diagnostic.goto_next, { desc = "LSP Next Diagnostic", buffer = 0 })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "LSP Previous Diagnostic", buffer = 0 })

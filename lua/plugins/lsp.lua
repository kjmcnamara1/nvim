return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPost",
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = {
      "folke/neodev.nvim",                 -- nvim config and plugin authoring
      "williamboman/mason-lspconfig.nvim", -- automatically install LSPs
      "hrsh7th/cmp-nvim-lsp",              -- LSP completions
      "nvimtools/none-ls.nvim",            -- new community fork of null-ls (wrap DAP, linters, and formatters as LSPs)
      "kevinhwang91/nvim-ufo",             -- code folding
      "kevinhwang91/promise-async",
    },
    config = function()
      -- local null_ls = require("null-ls")
      -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- local lspconfig = require("lspconfig")

      -- require("neodev").setup()

      -- require("mason").setup()

      -- require("mason-lspconfig").setup({
      --   ensure_installed = { "lua_ls" },
      --   automatic_installation = true,
      -- })


      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      -- capabilities.textDocument.foldingRange = {
      --   dynamicRegistration = false,
      --   lineFoldingOnly = true,
      -- }

      -- Add rounded borders to hover and signature popups
      local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
      }

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

      --   local language_servers = require("lspconfig").util.available_servers()

      --   for _, ls in ipairs(language_servers) do
      --   require("lspconfig")[ls].setup({ capabilities = capabilities })
      -- end

      --   -- fold options for ufo
      --   vim.opt.foldcolumn = "1"
      --   vim.opt.foldlevel = 99
      --     vim.opt.foldlevelstart = 99
      --     vim.opt.foldenable = true

      --     require("ufo").setup()

      --   null_ls.setup({
      --     sources = {
      --       null_ls.builtins.formatting.stylua,
      --       null_ls.builtins.formatting.black,
      --       null_ls.builtins.formatting.isort,
      --       --null_ls.builtins.diagnostics.eslint_d,
      --       null_ls.builtins.formatting.prettier,
      --     },
      --   })

      -- Configure border for LspInfo ui
      require("lspconfig.ui.windows").default_options.border = "rounded"
    end,
    keys = {
      { "K",          vim.lsp.buf.hover,                         desc = "LSP Hover",                   buffer = 0 },
      { "<leader>k",  vim.lsp.buf.signature_help,                desc = "LSP Signature Documentation", buffer = 0 },
      { "gd",         "<cmd>Telescope lsp_definitions<cr>",      desc = "LSP Definition",              buffer = 0 },
      { "gD",         vim.lsp.buf.declaration,                   desc = "LSP Declaration",             buffer = 0 },
      { "gr",         "<cmd>Telescope lsp_references<cr>",       desc = "LSP References",              buffer = 0 },
      { "gi",         "<cmd>Telescope lsp_implementations<cr>",  desc = "LSP Implementations",         buffer = 0 },
      { "gt",         "<cmd>Telescope lsp_type_definitions<cr>", desc = "LSP Type Definitions",        buffer = 0 },
      { "<leader>ca", vim.lsp.buf.code_action,                   desc = "LSP Code Action",             buffer = 0, mode = { "n", "v" } },
      { "<leader>cf", vim.lsp.buf.format,                        desc = "LSP Format",                  buffer = 0, mode = { "n", "v" } },
      { "<leader>rs", "<cmd>LspRestart<cr>",                     desc = "LSP Restart Server",          buffer = 0 },
      -- { '<leader>cr', vim.lsp.buf.rename, desc = 'LSP [r]e[n]ame' },
    },
  },
  {
    "smjonas/inc-rename.nvim",
    config = true,
    cmd = "IncRename",
    keys = {
      {
        "<leader>cr",
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "LSP Rename",
        buffer = 0,
      },
    },
  },
  {
    -- automatically install LSPs
    "williamboman/mason-lspconfig.nvim",
    dependencies = "williamboman/mason.nvim",
    lazy = true,
    opts = {
      automatic_installation = true,
      ensure_installed = {
        "lua_ls",
        "pyright",
        "ruff_lsp",
      },
    },
  },

  -- -- automatically install debuggers, linters, and formatters
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = "williamboman/mason.nvim",
    -- lazy=true,
    opts = {
      automatic_installation = true,
      ensure_installed = {
        "stylua",
        "prettier",
        -- "blue",
        "debugpy",
      },
    },
  },

  -- ui to install LSPs, DAPs, linters, and formatters
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = { ui = { border = "rounded" } },
  },
}

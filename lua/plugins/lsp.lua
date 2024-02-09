return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPost",
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = {
      "folke/neodev.nvim",                 -- nvim config and plugin authoring
      -- "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim", -- automatically install LSPs
      "hrsh7th/cmp-nvim-lsp",              -- LSP completions
      "nvimtools/none-ls.nvim",            -- new community fork of null-ls (wrap DAP, linters, and formatters as LSPs)
      { "smjonas/inc-rename.nvim", config = true },
      "kevinhwang91/nvim-ufo",
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

      require("inc_rename").setup()

      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      -- capabilities.textDocument.foldingRange = {
      --   dynamicRegistration = false,
      --   lineFoldingOnly = true,
      -- }

      local handlers = {
        ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
        ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
      }


      require("mason-lspconfig").setup_handlers({
        function(ls)
          require('lspconfig')[ls].setup({
            capabilities = capabilities,
            handlers = handlers,
          })
        end,
        lua_ls = function()
          require('lspconfig').lua_ls.setup({
            capabilities = capabilities,
            handlers = handlers,
            settings = { -- custom settings for lua
              Lua = {
                -- make the language server recognize "vim" global
                diagnostics = {
                  globals = { 'vim' },
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
        end
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
      require('lspconfig.ui.windows').default_options.border = 'rounded'
    end,
    keys = {
      { "K",         vim.lsp.buf.hover,                   desc = "LSP Hover",                   buffer = 0 },
      { '<leader>k', vim.lsp.buf.signature_help,          desc = 'LSP Signature Documentation', buffer = 0 },
      { "gd",        vim.lsp.buf.definition,              desc = "LSP Definition",              buffer = 0 },
      { "gr",        '<cmd>Telescope lsp_references<cr>', desc = "LSP References",              buffer = 0 },
      -- { "<leader>rn", vim.lsp.buf.rename, desc = "LSP [r]e[n]ame" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "LSP Code Action", mode = { "n", "v" }, buffer = 0 },
      { "<leader>cf", vim.lsp.buf.format,      desc = "LSP Format",      mode = { 'n', 'v' }, buffer = 0 },
      {
        "<leader>cr",
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "LSP Rename",
        buffer = 0
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim", -- automatically install LSPs
    dependencies = 'williamboman/mason.nvim',
    lazy = true,
    opts = {
      automatic_installation = true,
      ensure_installed = {
        'lua_ls'
      },
    },
  },

  -- ui to install LSPs, DAPs, linters, and formatters
  {
    'williamboman/mason.nvim',
    cmd = { 'Mason', 'MasonInstall', 'MasonUpdate' },
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    build = ':MasonUpdate',
    opts = { ui = { border = "rounded" } },
  }
}

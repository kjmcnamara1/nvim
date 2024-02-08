return {
  -- {
  --   "neovim/nvim-lspconfig",
  --   event = "BufReadPost",
  --   cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
  --   dependencies = {
  --     "williamboman/mason.nvim",
  --     "williamboman/mason-lspconfig.nvim",
  --     "hrsh7th/cmp-nvim-lsp",
  --     "nvimtools/none-ls.nvim",
  --     "folke/neodev.nvim",
  --     "smjonas/inc-rename.nvim",
  --     "kevinhwang91/nvim-ufo",
  --     "kevinhwang91/promise-async",
  --   },
  --   config = function()
  --     local null_ls = require("null-ls")
  --     -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
  --     -- local lspconfig = require("lspconfig")

  --     require("neodev").setup()

  --     require("mason").setup({ ui = { border = "rounded" } })

  --     require("mason-lspconfig").setup({
  --       ensure_installed = { "lua_ls" },
  --       automatic_installation = true,
  --     })

  --     require("inc_rename").setup()

  --     local capabilities = vim.lsp.protocol.make_client_capabilities()
  --     capabilities.textDocument.foldingRange = {
  --       dynamicRegistration = false,
  --       lineFoldingOnly = true,
  --     }

  --     local language_servers = require("lspconfig").util.available_servers()

  --     for _, ls in ipairs(language_servers) do
  --       require("lspconfig")[ls].setup({ capabilities = capabilities })
  --     end

  --     -- fold options for ufo
  --     vim.opt.foldcolumn = "0"
  --     vim.opt.foldlevel = 99
  --     vim.opt.foldlevelstart = 99
  --     vim.opt.foldenable = true

  --     require("ufo").setup()

  --     null_ls.setup({
  --       sources = {
  --         null_ls.builtins.formatting.stylua,
  --         null_ls.builtins.formatting.black,
  --         null_ls.builtins.formatting.isort,
  --         --null_ls.builtins.diagnostics.eslint_d,
  --         null_ls.builtins.formatting.prettier,
  --       },
  --     })
  --   end,
  --   keys = {
  --     { "K", vim.lsp.buf.hover, desc = "LSP Hover" },
  --     { "gd", vim.lsp.buf.definition, desc = "LSP [g]o To [d]efinition" },
  --     -- { "<leader>rn", vim.lsp.buf.rename, desc = "LSP [r]e[n]ame" },
  --     {
  --       "<leader>rn",
  --       function()
  --         return ":IncRename " .. vim.fn.expand("<cword>")
  --       end,
  --       expr = true,
  --       desc = "LSP [r]e[n]ame",
  --     },
  --     { "<leader>ca", vim.lsp.buf.code_action, desc = "LSP [c]ode [a]ction", mode = { "n", "v" } },
  --     { "<leader>fm", vim.lsp.buf.format, desc = "LSP [f]or[m]at" },
  --   },
  -- },
}

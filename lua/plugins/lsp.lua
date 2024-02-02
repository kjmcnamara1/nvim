return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPost",
    cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "nvimtools/none-ls.nvim",
      "folke/neodev.nvim",
      "smjonas/inc-rename.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      require("neodev").setup()

      require("mason").setup({ ui = { border = "rounded" } })

      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
        automatic_installation = true,
      })

      require("inc_rename").setup({
        -- input_buffer_type = "dressing",
      })

      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.pyright.setup({ capabilities = capabilities })
      lspconfig.ruff_lsp.setup({ capabilities = capabilities })
      lspconfig.eslint.setup({ capabilities = capabilities })

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          --null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.formatting.prettier,
        },
      })
    end,
    keys = {
      { "K", vim.lsp.buf.hover, desc = "LSP Hover" },
      { "gd", vim.lsp.buf.definition, desc = "LSP [g]o To [d]efinition" },
      -- { "<leader>rn", vim.lsp.buf.rename, desc = "LSP [r]e[n]ame" },
      {
        "<leader>rn",
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "LSP [r]e[n]ame",
      },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "LSP [c]ode [a]ction", mode = { "n", "v" } },
      { "<leader>fm", vim.lsp.buf.format, desc = "LSP [f]or[m]at" },
    },
  },
  --  {
  --    "LhKipp/nvim-nu",
  --    config = function()
  --      require("nu").setup()
  --    end,
  --  },
}

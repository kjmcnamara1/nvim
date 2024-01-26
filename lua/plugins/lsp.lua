return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls" },
      automatic_installation = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.pyright.setup({})
      lspconfig.ruff_lsp.setup({})
      lspconfig.eslint.setup({})
    end,
    keys = {
      { "K", vim.lsp.buf.hover, desc = "LSP Hover" },
      { "gd", vim.lsp.buf.definition, desc = "LSP [g]o To [d]efinition" },
      { "<leader>rn", vim.lsp.buf.rename, desc = "LSP [r]e[n]ame" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "LSP [c]ode [a]ction", mode = { "n", "v" } },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          --null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.formatting.prettier,
        },
      })

      --vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, {})
    end,
    keys={{ "<leader>fm", vim.lsp.buf.format,desc='LSP [f]or[m]at'}},
  },
  --  {
  --    "LhKipp/nvim-nu",
  --    config = function()
  --      require("nu").setup()
  --    end,
  --  },
}

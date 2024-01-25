return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.pyright.setup({})
      lspconfig.ruff_lsp.setup({})
      lspconfig.eslint.setup({})
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {})
      vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, {})
    end,
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

      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
  },
--  {
--    "LhKipp/nvim-nu",
--    config = function()
--      require("nu").setup()
--    end,
--  },
}

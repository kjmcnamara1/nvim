vim.bo.tabstop = 4
vim.bo.softtabstop = 4

vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    require("nvim-treesitter.parsers").mojo = {
      install_info = {
        url = "https://github.com/lsh/tree-sitter-mojo",
        revision = "03966fb3f209bea86844aab3bd0f2158a5a8bb8d",
        queries = "queries",
      },
      tier = 2,
    }
  end
})

-- Enable LSP since it is not in mason (and enableable by mason-lspconfig)
vim.lsp.enable("mojo")

vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.commentstring = "# %s"

vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    require("nvim-treesitter.parsers").xonsh = {
      install_info = {
        url = "https://github.com/FoamScience/tree-sitter-xonsh",
        revision = "8dbee2b1946e00492167f5c3f68a948343b57e48",
        queries = "queries",
      },
      tier = 2,
    }
  end
})

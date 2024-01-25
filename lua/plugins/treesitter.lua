return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    -- NOTE: additional parser
    { "nushell/tree-sitter-nu" },
  },
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      ensure_installed = { "lua", "bash", "vim", "vimdoc", "javascript", "html", "css", "python" },
      auto_install = true,
      --sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}

pack_add({
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/jbyuki/one-small-step-for-vimkind",
})

require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    { path = "snacks.nvim",        words = { "Snacks" } },
  }
})

vim.pack.add({ "https://github.com/folke/lazydev.nvim" })

require("lazydev").setup({
  library = {
    "nvim-dap-ui",
    --   vim.fn.stdpath("config") .. "/lua",
    --   { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    --   { path = "snacks.nvim",        words = { "Snacks" } },
  }
})

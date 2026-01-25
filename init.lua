vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("core.options")

vim.pack.add({ "https://github.com/rmehri01/onenord.nvim" })
require("onenord").setup(
  {
    styles = {
      comments = "italic",
      keywords = "bold",
    },
  }
)

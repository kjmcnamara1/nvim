require("ibl").setup({
  indent = { char = "" },
  whitespace = {
    --highlight = { "IblRed", "IblYellow", "IblBlue", "IblOrange", "IblGreen", "IblPurple", "IblCyan" },
    remove_blankline_trail = false,
  },
  scope = { enabled = false },
  exclude = {
    filetypes = {
      "help",
      "alpha",
      "dashboard",
      "neo-tree",
      "Trouble",
      "trouble",
      "lazy",
      "mason",
      "notify",
      "toggleterm",
      "lazyterm",
    },
  },
})

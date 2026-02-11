-- TODO: add keymap for double comment/deprecated
pack_add({ "https://github.com/numToStr/Comment.nvim" })

require("Comment").setup({
  -- sticky = false,
  ignore = "^%s*$", -- Ignore blank lines
})

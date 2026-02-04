vim.pack.add({ "https://github.com/lambdalisue/vim-suda" })

vim.g.suda_smart_edit = 1

wk.add({
  mode = { "n", "x" },
  { "<c-s>",   "<cmd>w! ++p<cr>",           desc = "Save file" },
  { "<c-s-s>", "<cmd>noautocmd w! ++p<cr>", desc = "Save w/o formatting" },
})

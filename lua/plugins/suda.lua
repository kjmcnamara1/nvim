return {
  "lambdalisue/vim-suda",
  lazy = false,
  cmd = { "SudaRead", "SudaWrite" },
  keys = {
    mode = { "n", "x" },
    { "<c-s>",   "<cmd>w! ++p<cr>",           desc = "Save file" },
    { "<c-s-s>", "<cmd>noautocmd w! ++p<cr>", desc = "Save w/o formatting" },
  },
  init = function()
    vim.g.suda_smart_edit = 1
  end
}

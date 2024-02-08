return {
  "kevinhwang91/nvim-ufo",
  event = 'BufEnter',
  dependencies = "kevinhwang91/promise-async",
  opts = {
    provider_selector = function(_bufnr, _filetype, _buftype)
      return {'treesitter','indent'}
    end,
  }
}

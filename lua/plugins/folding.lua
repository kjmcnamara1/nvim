return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  event = "BufEnter",
  cmd = { "UfoEnable", "UfoInspect", "UfoAttach", "UfoEnableFold", "UfoDisableFold" },
  keys = {
    { "zr", function() require("ufo").openFoldsExceptKinds() end,       desc = "Reduce fold level" },
    { "zR", function() require("ufo").openAllFolds() end,               desc = "Open all folds" },
    { "zm", function() require("ufo").closeFoldsWith() end,             desc = "Increase fold level" },
    { "zM", function() require("ufo").closeAllFolds() end,              desc = "Close all folds" },
    { "zK", function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Preview folded text or LSP hover" },
    { "]z", function() require("ufo").goNextClosedFold() end,           desc = "Next fold" },
    { "[z", function() require("ufo").goPreviousClosedFold() end,       desc = "Previous fold" },
  },
  opts = {
    close_fold_kinds = { "imports", "comment" },
    -- provider_selector = function(_bufnr, _filetype, _buftype)
    --   return { "treesitter", "indent" }
    -- end,
  },
  config = function(_, opts)
    -- Folding options for ufo plugin
    vim.opt.foldcolumn = "auto:9"
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    vim.opt.foldenable = true

    require("ufo").setup(opts)
  end,
}

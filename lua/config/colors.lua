if profile() == "vscode" then
  return
end

pack_add({
  "https://github.com/rmehri01/onenord.nvim",
  "https://github.com/brenoprata10/nvim-highlight-colors",
})

_G.colors = require("onenord.colors").load()

wk.add({
  { "<localleader>H", "<cmd>HighlightColors Toggle<cr>", desc = "Toggle Highlight Colors" },
})

require("onenord").setup({
  fade_nc = true,
  styles = {
    comments = "italic",
    keywords = "bold",
  },
  custom_highlights = {
    -- DiagnosticUnderlineError = { undercurl = true, underline = false },
    -- LspDiagnosticsUnderlineError = { undercurl = true, underline = false },
    -- LspReferenceText = { bg = "yellow" },
    -- LspReferenceRead = { bg = "red" },
    -- LspReferenceWrite = { bg = "blue" },
  }
})

require("nvim-highlight-colors").setup({
  render = "virtual",
  virtual_symbol_position = "eow",
  virtual_symbol_prefix = " ",
  virtual_symbol_suffix = "",
})

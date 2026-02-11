if profile() == "vscode" then
  return
end

pack_add({
  "https://github.com/rmehri01/onenord.nvim",
  "https://github.com/brenoprata10/nvim-highlight-colors",
})

wk.add({
  { "<localleader>H", "<cmd>HighlightColors Toggle<cr>", desc = "Toggle Highlight Colors" },
})

_G.colors = {
  fg = "#C8D0E0",
  fg_light = "#E5E9F0",
  bg = "#2E3440",
  active = "#353B49",
  float = "#3B4252",
  highlight = "#3F4758",
  highlight_dark = "#434C5E",
  selection = "#4C566A",
  light_gray = "#6C7A96",
  gray = "#646A76",
  light_red = "#DE878F",
  red = "#D57780",
  dark_red = "#BF616A",
  blue = "#81A1C1",
  dark_blue = "#5E81AC",
  pink = "#E85B7A",
  dark_pink = "#E44675",
  light_cyan = "#8FBCBB",
  cyan = "#88C0D0",
  light_green = "#C1D3B2",
  green = "#A3BE8C",
  dark_green = "#719453",
  light_orange = "#DEB09A",
  orange = "#D08F70",
  light_purple = "#CDB3C8",
  purple = "#B48EAD",
  dark_purple = "#B988B0",
  light_yellow = "#F2DCB1",
  yellow = "#EBCB8B",
  dark_yellow = "#E0AE4B",

  error = "#BF616A",
  warn = "#D08F70",
  info = "#A3BE8C",
  hint = "#B988B0",

  diff_add = "#A3BE8C",
  diff_add_bg = "#394E3D",
  diff_change = "#5E81AC",
  diff_change_bg = "#39495D",
  diff_remove = "#D57780",
  diff_remove_bg = "#4D2B2E",
  diff_text_bg = "#405D7E",

  none = "NONE",
}

require("onenord").setup({
  fade_nc = true,
  styles = {
    -- comments = "italic",
    diagnostics = "undercurl",
  },
  custom_colors = colors,
  custom_highlights = {
    ["@comment.deprecated"] = { fg = colors.highlight, style = "italic,strikethrough" },
    ["@punctuation.quote"] = { fg = colors.dark_green },
    ["@string.prefix"] = { link = "@keyword" },
    ["@string.documentation"] = { fg = colors.gray },
    ["@function.macro"] = { fg = colors.cyan, style = "bold" },
    ["@constant.builtin"] = { style = "bold" },
    ["@variable.parameter"] = { fg = colors.dark_red, style = "italic" },
    ["@keyword"] = { fg = colors.dark_purple, style = "bold" },
    ["@keyword.function"] = { link = "@keyword.type" },
    ["@keyword.conditional"] = { style = "italic" },
    ["@keyword.import"] = { style = "italic" },
    ["@keyword.return"] = { style = "bold,italic" },
    ["@keyword.exception"] = { link = "@keyword.conditional" },
    ["@keyword.repeat"] = { link = "@keyword.conditional" },
    ["@lsp.type.decorator.python"] = { fg = colors.cyan },
    ["@lsp.type.selfParameter"] = { style = "italic" },
    ["@lsp.type.enum"] = { fg = colors.light_yellow, link = colors.none },
    ["@lsp.typemod.property.classMember"] = { style = "bold" },
    ["@lsp.typemod.class.builtin"] = { fg = colors.light_cyan },
    ["@lsp.typemod.variable.readonly"] = { fg = colors.light_orange },
    ["@lsp.mod.declaration"] = { style = "bold" },
    ["@module"] = { fg = colors.dark_yellow },

    SnacksPickerGitStatusModified = { fg = colors.yellow, link = colors.none },
    SnacksPickerGitStatusStaged = { fg = colors.dark_green, link = colors.none },
    SnacksPickerGitStatusRenamed = { fg = colors.blue, link = colors.none },
    SnacksPickerGitStatusUntracked = { fg = colors.light_gray, link = colors.none },

    MatchParen = { link = "IncSearch" },
    LspReferenceText = { style = colors.none },
    LspReferenceRead = { bg = colors.highlight, style = colors.none },
    LspReferenceWrite = { bg = colors.highlight, style = colors.none },
  },
})


require("nvim-highlight-colors").setup({
  render = "virtual",
  -- can't handle multiple colors on same line
  -- virtual_symbol_position = "eow",
  -- virtual_symbol_prefix = " ",
  -- virtual_symbol_suffix = "",
})

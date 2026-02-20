vim.b.snacks_indent = false
if profile() ~= "default" then
  return
end

pack_add({
  "https://github.com/OXY2DEV/markview.nvim",
  "https://github.com/iamcco/markdown-preview.nvim",
})

-- Install/update markdown-preview
-- vim.fn["mkdp#util#install"]()

wk.add({
  cond = function()
    return vim.bo.filetype == "markdown"
  end,
  { "<localleader>m", "<cmd>Markview toggle<cr>",       desc = "Toggle Render Markdown" },
  { "<localleader>M", "<cmd>Markview hybridToggle<cr>", desc = "Toggle Markview Hybrid Mode" },
  { "<c-t>",          "<cmd>Checkbox toggle<cr>",       desc = "Toggle Checkbox" },
  { "<leader>cb",     "<cmd>Checkbox interactive<cr>",  desc = "Interactive Checkbox" },
  { "<leader>cp",     "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview",           ft = "markdown" },
})

require("markview").setup({
  preview = {
    icon_provider = "mini",
    -- enable_hybrid_mode = true,
    -- linewise_hybrid_mode = true,
    -- hybrid_modes = { 'n' },
  },
  markdown_inline = {
    hyperlinks = {
      ["tel:"] = {
        icon = " ",
        hl = "MarkviewPalette2Fg",
      },
      ["maps.app.goo.gl/"] = {
        icon = "󰍎 ",
        hl = "MarkviewPalette1Fg",
      },
      ["mailto:"] = {
        icon = "󰇮 ",
        hl = "MarkviewPalette7Fg",
      },
    },
  },
})
require("markview.extras.checkboxes").setup()

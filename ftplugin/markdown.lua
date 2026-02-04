vim.pack.add({ "https://github.com/OXY2DEV/markview.nvim" })

wk.add({
  cond = function()
    return vim.bo.filetype == "markdown"
  end,
  { "<leader>um", "<cmd>Markview toggle<cr>",       desc = "Toggle Render Markdown" },
  { "<leader>uM", "<cmd>Markview hybridToggle<cr>", desc = "Toggle Markview Hybrid Mode" },
  { "<c-t>",      "<cmd>Checkbox toggle<cr>",       desc = "Toggle Checkbox" },
  { "<leader>cb", "<cmd>Checkbox interactive<cr>",  desc = "Interactive Checkbox" },
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

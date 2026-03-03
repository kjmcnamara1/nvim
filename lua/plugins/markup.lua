return {

  {
    "OXY2DEV/markview.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.icons",
    },
    cond = profile() == "default",
    ft = "markdown",
    keys = {
      { "<localleader>m", "<cmd>Markview toggle<cr>",       desc = "Toggle Render Markdown" },
      { "<localleader>M", "<cmd>Markview hybridToggle<cr>", desc = "Toggle Markview Hybrid Mode" },
      { "<c-t>",          "<cmd>Checkbox toggle<cr>",       desc = "Toggle Checkbox" },
      { "<leader>cb",     "<cmd>Checkbox interactive<cr>",  desc = "Interactive Checkbox" },
    },
    opts = {
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
    },
    config = function(_, opts)
      require("markview").setup(opts)
      require("markview.extras.checkboxes").setup()
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    cond = profile() == "default",
    ft = "markdown",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    keys = {
      { "<leader>cp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview", ft = "markdown" },
    },
    build = function(plugin)
      vim.cmd("!cd " .. plugin.dir .. " && cd app && ./install.sh")
    end,

  },

}

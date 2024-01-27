return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  opts = {
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    filesystem = {
      group_empty_dirs = true,
      hijack_netrw_behavior = "open_default",
    },
  },
  keys = {
    { "<leader>e", ":Neotree toggle reveal<cr>", desc = "NeoTree Explorer", silent = true },
    { "<leader>ge", ":Neotree toggle reveal source=git_status<cr>", desc = "NeoTree Git Explorer", silent = true },
    { "<leader>oe", ":Neotree toggle reveal source=document_symbols<cr>", desc = "NeoTree Symbols Outline", silent = true },
  },
}

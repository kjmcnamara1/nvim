return {
  "folke/persistence.nvim",
  cond = profile() == "default",
  event = "BufReadPre",
  keys = {
    { "<c-q>",      "<cmd>qa<cr>",                                            desc = "Quit NeoVim",          mode = { "n" } },
    { "<c-s-q>",    "<cmd>lua require('persistence').stop()<cr><cmd>qa!<cr>", desc = "Force Quit NeoVim",    mode = { "n" } },
    { "<c-r>",      "<cmd>restart lua require('persistence').load()<cr>",     desc = "Restart NeoVim",       mode = { "n" } },
    { "<c-s-r>",    "<cmd>restart +qa!<cr>",                                  desc = "Force Restart NeoVim", mode = { "n" } },
    { "<leader>ss", function() require("persistence").select() end,           desc = "Select Session",       mode = { "n", "x" } }
  },
  opts = {},
}

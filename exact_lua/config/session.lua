if profile() ~= "default" then
  return
end

vim.pack.add({ "https://github.com/folke/persistence.nvim" })

require("persistence").setup()

wk.add({
  { "<c-q>",      "<cmd>qa<cr>",                                            desc = "Quit NeoVim",          mode = { "n" } },
  { "<c-s-q>",    "<cmd>lua require('persistence').stop()<cr><cmd>qa!<cr>", desc = "Force Quit NeoVim",    mode = { "n" } },
  { "<c-r>",      "<cmd>restart lua require('persistence').load()<cr>",     desc = "Restart NeoVim",       mode = { "n" } },
  { "<c-s-r>",    "<cmd>restart +qa!<cr>",                                  desc = "Force Restart NeoVim", mode = { "n" } },
  { "<leader>ss", require("persistence").select,                            desc = "Select Session",       mode = { "n", "x" } }
})

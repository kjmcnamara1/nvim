if profile() ~= "default" then
  return
end

pack_add({ "https://github.com/HotThoughts/jjui.nvim" })

require("jjui").setup({
  floating_window_winblend = 5,
  floating_window_scaling_factor = 1,
})
wk.add({
  { "<leader>jj", "<cmd>JJUI<cr>",                  desc = "JJUI" },
  { "<leader>jc", "<cmd>JJUICurrentFile<cr>",       desc = "JJUI (current file)" },
  { "<leader>jl", "<cmd>JJUIFilter<cr>",            desc = "JJUI Log" },
  { "<leader>jf", "<cmd>JJUIFilterCurrentFile<cr>", desc = "JJUI Log (current file)" },
})

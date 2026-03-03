return {
  "folke/snacks.nvim",
  cond = profile() == "minimal",
  priority = 1000,
  lazy = false,
  config = function()
    require("snacks").setup({ terminal = {} })
  end
}

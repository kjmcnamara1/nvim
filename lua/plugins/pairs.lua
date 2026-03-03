return {
  "windwp/nvim-autopairs",
  event = "VeryLazy",
  cond = profile() ~= "vscode",
  opts = {
    check_ts = true,
  },
}

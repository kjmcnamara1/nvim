return {
  "nvim-neorg/neorg",
  cond = profile() == "default",
  lazy = false,  -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = "*", -- Pin Neorg to the latest stable release
  opts = {},
}

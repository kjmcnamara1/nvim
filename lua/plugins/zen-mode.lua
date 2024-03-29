local map=require('config').map_keys

map('n',"<leader>z", "<cmd>ZenMode<cr>", {desc = "Toggle Zen Mode" })

local opts = {
  window = {
    options = {
      -- signcolumn = "no",
      number = false,
      relativenumber = false,
      cursorline = false,
      cursorcolumn = false,
      foldcolumn = "0",
      list = false,
      scrolloff = 999,
    }
  },
  plugins = {
    options = {
      enabled = true,
      laststatus = 0,
    },
    twilight = { enabled = true },
    gitsigns = { enabled = true },
    tmux = { enabled = true },
    wezterm = { enabled = true, font = "+2" },
  },
}

require('zen-mode').setup(opts)

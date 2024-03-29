local map=require('config').map_keys

map('n','<leader>cm','<cmd>Mason<cr>',{desc='Mason'})

local opts = {
  ui = {
    border = "rounded",
    height = .8,
    icons = {
      package_installed = "✔️",
      package_pending = "",
      package_uninstalled = "✗",
    }
  }
}

require('mason').setup(opts)

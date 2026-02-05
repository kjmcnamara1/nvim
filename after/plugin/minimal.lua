if profile() ~= "minimal" then
  return
end

local o          = vim.opt

o.laststatus     = 0 -- Turn off statusline
o.scrolloff      = 0
o.sidescrolloff  = 0
o.number         = false
o.relativenumber = false

o.cmdheight      = 0
o.showmode       = false
o.showcmd        = false
o.shortmess:append("F")

vim.pack.add({ "https://github.com/folke/snacks.nvim" })
require("snacks").setup({ terminal = {} })

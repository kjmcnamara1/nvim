if profile() ~= "minimal" then
  return
end

vim.opt.laststatus     = 0 -- Turn off statusline
vim.opt.scrolloff      = 0
vim.opt.sidescrolloff  = 0
vim.opt.number         = false
vim.opt.relativenumber = false

vim.opt.cmdheight      = 0
vim.opt.showmode       = false
vim.opt.showcmd        = false
vim.opt.shortmess:append("F")

wk.add({
  { "<esc>", "ZQ", desc = "Quit" },
})

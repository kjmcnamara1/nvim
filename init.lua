-- Vim options
require("options")

-- Custom keymaps
require("keymaps")

-- Custom autocmds
require("autocmds")

-- ===================== Lazy.nvim Plugin Manager =============================
-- Set lazy data folder location where plugins will download
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

-- Add plugin data path to beginning of vim runtime path
vim.opt.rtp:prepend(lazypath)

-- Load Lazy.nvim
require("lazy").setup("plugins", {
  ui = {
    border = "rounded",
    title = "Lazy Plugin Manager",
  },
  checker = { enabled = true, frequency = 86400 },
  change_detection = { notify = false },
})

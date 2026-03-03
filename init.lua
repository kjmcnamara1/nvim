-- TODO: make sure delete, change, and put do not change system register(+)

-- Add this if it doesn't exist
if not table.pack then
  ---@diagnostic disable-next-line: duplicate-set-field
  table.pack = function(...)
    return { n = select("#", ...), ... }
  end
end

-- Also, handle unpack (it's global in 5.1, but in table in 5.2+)
if not table.unpack then
  table.unpack = unpack
end

vim.g.mapleader = " "
vim.g.maplocalleader = "_"

_G.profile = function()
  if vim.g.minimal then
    return "minimal"
  elseif vim.g.vscode then
    return "vscode"
  else
    return "default"
  end
end

require("config.options")
require("config.autocmds")
require("config.lazy")

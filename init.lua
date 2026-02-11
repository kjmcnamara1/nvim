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
vim.g.no_plugin_maps = true

_G.profile = function()
  if vim.g.minimal then
    return "minimal"
  elseif vim.g.vscode then
    return "vscode"
  else
    return "default"
  end
end

require("config.options")  -- all
require("config.autocmds") -- all

_G.pack_add = function(packs)
  vim.pack.add(packs, { confirm = false })
end

require("config.plenary")    -- all
require("config.which_key")  -- all
require("config.colors")     -- default
require("config.snacks")     -- default?
require("config.session")    -- default
require("config.flash")      -- all
require("config.todo")       -- default
require("config.treesitter") -- all
require("config.icons")      -- default? or all
require("config.files")      -- default
require("config.cursor")     -- all
require("config.comment")    -- all
require("config.dial")       -- all
require("config.pairs")      -- all
require("config.status")     -- default
require("config.buffers")    -- default
require("config.scrollbar")  -- default
require("config.splits")     -- default
require("config.git")        -- default
-- require("config.jjui")       -- default
require("config.lsp")        -- default
require("config.completion") -- snippets all | completion/ai default
require("config.debug")      --  default
require("config.suda")       -- all? or default
require("config.chezmoi")    -- default
require("config.agent")      -- default

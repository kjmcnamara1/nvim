local o = vim.opt

-- ======================== SESSION ========================

--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end) -- Sync clipboard between OS and Neovim.
o.autowrite      = true                                      -- Auto write file when leaving buffer
-- o.timeoutlen     = 300                                       -- Decrease mapped sequence wait time

o.undofile       = true  -- Enable persistent undo (see also `:h undodir`)
o.undolevels     = 10000 -- Set undo history size

o.confirm        = true  -- Raise dialog asking to save current file

-- ======================== WINDOW ========================

-- Always keep n lines above/below cursor unless at start/end of file
o.scrolloff      = 10 -- keep cursor in center of screen == 999
o.sidescrolloff  = 5
o.cmdheight      = 0  -- Hide command line except when entering a command

-- ======================== EDITOR ========================

o.mouse          = "a"  -- Enable mouse for all available modes
o.mousemoveevent = true -- Enable mouse hover events

-- Enable relative line numbers with current line as absolute number
o.number         = true
o.relativenumber = true

o.expandtab      = true -- Insert spaces instead of tab
o.tabstop        = 2    -- Set tab to 2 spaces
o.softtabstop    = 2
o.shiftwidth     = 0    -- Number of spaces to use for each step of auto-indent (0 matches `tabstop`)
o.shiftround     = true -- Round indent to multiple of 'shiftwidth'

-- Appearance
o.breakindent    = true -- Indent wrapped lines to match line start
o.cursorline     = true -- Highlight current line
o.linebreak      = true -- Wrap long lines at 'breakat' (if 'wrap' is set)
o.splitbelow     = true -- Horizontal splits will be below
o.splitright     = true -- Vertical splits will be to the right

o.inccommand     = "split" -- Preview substitutions live, as you type!
o.wrap           = false -- Display long lines as just one line

o.signcolumn     = "yes" -- Always show signcolumn 2 wide to accomodate gitsigns and lsp diagnostics

o.list           = true -- Show invisible characters
o.listchars      = { tab = " ", trail = "∙", extends = "󰇘", precedes = "󰇘", conceal = "", nbsp = "␣" } -- Invisible characters

o.fillchars      = {
  foldopen = "󰅀", --'foldcolumn' char for opened fold
  foldclose = "󰅂", -- 'foldcolumn' char for closed fold
  -- fold = "⸱",
  fold = " ", -- Fill char for 'foldtext'
  foldsep = " ", -- 'foldcolumn' char for inside opened folds
  eob = " ", -- Don't show '~' outside of buffer
}

function _G.CustomFoldText()
  local line = vim.fn.getline(vim.v.foldstart)
  local fold_size = vim.v.foldend - vim.v.foldstart + 1
  local percentage = math.floor((fold_size / vim.fn.line('$')) * 100)
  return line .. " ... (" .. fold_size .. " lines: " .. percentage .. "%)"
end

-- o.foldtext       = "v:lua.CustomFoldText()"
o.foldtext       = "";

o.foldenable     = true
o.foldlevelstart = 99
-- o.foldmethod     = "expr";
-- o.foldexpr       = "v:lua.vim.treesitter.foldexpr()";
-- o.foldexpr       = "v:lua.vim.lsp.foldexpr()";

o.shortmess:append("WIcC") -- Reduce command line messages
o.splitkeep     = "screen" -- Reduce scroll during window split
o.termguicolors = true     -- Enable gui colors

-- Editing
o.ignorecase    = true    -- Ignore case when searching (use `\C` to force not doing that)
o.incsearch     = true    -- Show search results while typing
o.infercase     = true    -- Infer letter cases for a richer built-in keyword completion
o.smartcase     = true    -- Don't ignore case when searching if pattern has upper case
o.smartindent   = true    -- Make indenting smart

o.virtualedit   = "block" -- Allow going past the end of line in visual block mode
o.textwidth     = 80      -- Set wrap text width
o.formatoptions = "qcrj1" -- Don't autoformat comments when useing 'o' or 'O'

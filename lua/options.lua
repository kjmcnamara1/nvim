-- ======================== KEYS ========================

-- Map leader key to <space> and localleader to '\'
vim.g.mapleader        = " "
vim.g.maplocalleader   = "\\"

-- ======================== EDITOR ========================

-- Enable relative line numbers with current line as absolute number
vim.opt.number         = true
vim.opt.relativenumber = true

vim.opt.expandtab      = true -- Insert spaces instead of tab
vim.opt.tabstop        = 2    -- Set tab to 2 spaces
vim.opt.softtabstop    = 2
vim.opt.shiftwidth     = 0    -- Number of spaces to use for each step of auto-indent (0 matches `tabstop`)
vim.opt.shiftround     = true -- Round indent to multiple of 'shiftwidth'

-- Appearance
vim.opt.breakindent    = true -- Indent wrapped lines to match line start
vim.opt.cursorline     = true -- Highlight current line
vim.opt.linebreak      = true -- Wrap long lines at 'breakat' (if 'wrap' is set)
vim.opt.splitbelow     = true -- Horizontal splits will be below
vim.opt.splitright     = true -- Vertical splits will be to the right

vim.opt.ruler          = false -- Don't show cursor position in command line
vim.opt.showmode       = false -- Don't show mode in command line
vim.opt.wrap           = false -- Display long lines as just one line


-- Editing
vim.opt.ignorecase    = true                        -- Ignore case when searching (use `\C` to force not doing that)
vim.opt.incsearch     = true                        -- Show search results while typing
vim.opt.infercase     = true                        -- Infer letter cases for a richer built-in keyword completion
vim.opt.smartcase     = true                        -- Don't ignore case when searching if pattern has upper case
vim.opt.smartindent   = true                        -- Make indenting smart

vim.opt.completeopt   = "menuone,noinsert,noselect" -- Customize completions
vim.opt.virtualedit   = "block"                     -- Allow going past the end of line in visual block mode
vim.opt.formatoptions = "qjl1"                      -- Don't autoformat comments

-- ======================== WINDOW ========================

-- Always keep n lines above/below cursor unless at start/end of file
vim.opt.scrolloff      = 5 -- keep cursor in center of screen == 999
vim.opt.sidescrolloff  = 5

-- Global statusline for all windows -- Handled by lualine opt
-- vim.opt.laststatus = 3

-- ======================== SESSION ========================

vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer

vim.opt.clipboard      = "unnamedplus" -- Sync with system clipboard
vim.opt.autowrite      = true          -- Auto write file when leaving ubffer
vim.opt.updatetime     = 200           -- Save swap file and trigger CursorHold
vim.opt.swapfile       = false         -- Disable swap file

vim.opt.undofile       = true          -- Enable persistent undo (see also `:h undodir`)
vim.opt.undolevels     = 10000         -- Set undo history size
vim.opt.backup         = false         -- Don't store backup while overwriting the file
vim.opt.writebackup    = false         -- Don't store backup while overwriting the file

-- Items to remember for saving/loading sessions
vim.opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

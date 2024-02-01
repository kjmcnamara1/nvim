-- ======================== KEYS ========================

-- Map leader key to <space> and localleader to '\'
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Keymap timeout length in ms
-- opt.timeoutlen = 300

-- ======================== EDITOR ========================

-- Enable relative line numbers with current line as absolute number
vim.opt.number = true
vim.opt.relativenumber = true

-- Set tab to 2 spaces and round indent
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.shiftround = true

-- Enable auto indenting and set to spaces
vim.opt.smartindent = true
vim.opt.shiftwidth = 2

-- Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
vim.opt.breakindent = true

-- Disable text wrap
vim.opt.wrap = false

-- Enable incremental searching
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Enable ignorecase + smartcase for better searching with '/'
vim.opt.ignorecase = true
vim.opt.smartcase = true -- Don't ignore case with capitals

-- Preview incremental substitute
-- vim.opt.inccommand = "split"

-- Show invisible characters
vim.opt.list = true
vim.opt.listchars = "trail:∙,extends:󰇘,precedes:󰇘,conceal:"

-- Enable highlighting of the current line
vim.opt.cursorline = true

-- Place a column line
-- vim.opt.colorcolumn = '80'

-- Allow cursor to move past end of line in visual block mode
-- vim.opt.virtualedit = "block"

-- Vim Autoformatting Options
-- vim.g.autoformat = true
-- vim.opt.formatoptions = "jcroqlnt" -- tcqj
-- vim.opt.grepformat = "%f:%l:%c:%m"
-- vim.opt.grepprg = "rg --vimgrep"
-- vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })

-- Jump to matching bracket when inserting
-- vim.opt.showmatch = true

-- Conceal text options
-- vim.opt.conceallevel = 3 -- Hide * markup for bold and italic
-- vim.opt.concealcursor = 'nc'

-- ======================== WINDOW ========================

-- Enable mouse mode
vim.opt.mouse = "a"

-- Split new windows below and to right of current
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "screen"

-- Enable 24 bit color
vim.opt.termguicolors = true

-- Enable the sign column to prevent the screen from jumping
vim.opt.signcolumn = "yes"

-- Set fold settings
-- These options were reccommended by nvim-ufo
-- See: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- Always keep n lines above/below cursor unless at start/end of file
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

-- Minimum window width
vim.opt.winminwidth = 5

-- Global statusline for all windows -- Handled by lualine opt
-- vim.opt.laststatus = 3

-- Better completion experience
-- vim.opt.completeopt = "menu,menuone,noselect"

-- Pop Up Menu options
-- vim.opt.pumblend = 10
-- vim.opt.pumheight = 10

-- vim.opt.wildmode = "longest:full,full" -- Command-line completion mode

-- vim.opt.fillchars = {
--   foldopen = "",
--   foldclose = "",
--   -- fold = "⸱",
--   fold = " ",
--   foldsep = " ",
--   diff = "╱",
--   eob = " ",
-- }

-- ======================== SESSION ========================

-- Confirm to save changes before exiting modified buffer
vim.opt.confirm = true

-- Sync with system clipboard
vim.opt.clipboard = "unnamedplus"

-- Auto write file when leaving ubffer
vim.opt.autowrite = true

-- Save swap file and trigger CursorHold
vim.opt.updatetime = 200

-- Enable persistent undo history
vim.opt.undofile = true
vim.opt.undolevels = 10000

-- Options to save between sessions
-- vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

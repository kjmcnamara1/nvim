local function map(mode, lhs, rhs, opts)
  local default_opts = { noremap = true, silent = true }
  local new_opts = vim.tbl_deep_extend("force", default_opts, opts or {})

  return vim.keymap.set(mode, lhs, rhs, new_opts)
end

-- Quick exit from Insert mode
map("i", "jk", "<esc>", { desc = "Exit Insert mode" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Move cursor in Insert mode
map("i", "<c-h>", "<left>", { desc = "Move cursor left" })
map("i", "<c-j>", "<down>", { desc = "Move cursor down" })
map("i", "<c-k>", "<up>", { desc = "Move cursor up" })
map("i", "<c-l>", "<right>", { desc = "Move cursor right" })

-- Keep buffer centered during vertical movements
map("n", "<c-d>", "<c-d>zz", { remap = true, desc = "Scroll half page down" })
map("n", "<c-u>", "<c-u>zz", { remap = true, desc = "Scroll half page up" })
map("n", "{", "{zz", { remap = true, desc = "Scroll paragraph down" })
map("n", "}", "}zz", { remap = true, desc = "Scroll paragraph up" })
map("n", "n", "nzz", { remap = true, desc = "Next search result" })
map("n", "N", "Nzz", { remap = true, desc = "Previous search result" })
map("n", "<c-o>", "<c-o>zz", { remap = true, desc = "Previous jump" })
map("n", "<c-i>", "<c-i>zz", { remap = true, desc = "Next jump" })
map("n", "*", "*zz", { remap = true, desc = "Next word under cursor" })
map("n", "#", "#zz", { remap = true, desc = "Previous word under cursor" })

-- Unmap 's' for mini.surround
map('n', 's', '<nop>')

-- Paste in insert mode
map("i", "<c-v>", "<c-r>+", { desc = "Paste from system clipboard" })

-- Paste without losing the contents of the register
map("x", "<leader>p", '"_dP', { desc = "Paste without overwriting register" })

-- Capital U for Redo
map("n", "U", "<c-r>", { desc = "Redo" })

-- Better beginning / end of lines ( modes Norm, Vis, Sel, Opr)
map("", "H", "^", { desc = "Beginning of Line" })
map("", "L", "$", { desc = "End of Line" })

-- better up/down -- Included with mini.basics
-- map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map({ "n", 't' }, "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map({ "n", 't' }, "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map({ "n", 't' }, "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map({ "n", 't' }, "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Resize split windows to be equal size
map("n", "<leader>=", "<cmd>wincmd =<cr>", { desc = "Equal window size" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Press gx to open the link under the cursor
map("n", "gx", ":sil !open <cWORD><cr>")

-- Buffers
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Lazy Plugin Manager
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- New File
map("n", "<leader>n", "<cmd>enew<cr>", { desc = "New File" })

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Quit NeoVim
map("n", "<c-q>", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

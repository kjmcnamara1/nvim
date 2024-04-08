local function map(mode, lhs, rhs, opts)
  local default_opts = { noremap = true, silent = true }
  local new_opts = vim.tbl_deep_extend("force", default_opts, opts or {})

  return vim.keymap.set(mode, lhs, rhs, new_opts)
end


-- Quick exit from Insert mode
map("i", "jk", "<esc>", { desc = "Exit insert mode" })

-- Save file
map({ "i", "x", "n", "s" }, "<c-s>", "<cmd>w!<cr>", { desc = "Save file" })

-- Quit NeoVim
map("n", "<c-q>", "<cmd>qa<cr>", { desc = "Quit NeoVim" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Capital U for Redo
map("n", "U", "<c-r>", { desc = "Redo" })

-- Paste in insert mode
map("i", "<c-v>", "<c-r>+", { desc = "Paste from system clipboard" })

-- Move by visible lines.
map({ "n", "x" }, "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true })
map({ "n", "x" }, "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true })

-- Buffers & Tabs
map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New file" })
map("n", "<leader>'", "<cmd>e #<cr>", { desc = "Switch to other buffer" })

map("n", "<c-c>", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<a-s-h>", "<cmd>tabp<cr>", { desc = "Switch to previous tab" })
map("n", "<a-s-l>", "<cmd>tabn<cr>", { desc = "Switch to next tab" })
-- map("n", "<leader>`", "<cmd>exe 'tabn '.g:lasttab<cr>", { desc = "Switch to other tab" }) -- need to create an autocmd to record last tab number

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "=", "=gv")

-- Better beginning / end of lines ( modes Norm, Vis, Sel, Opr)
map("", "H", "^", { desc = "Beginning of Line" })
map("", "L", "$", { desc = "End of Line" })

-- Window navigation
map({ "n", "t" }, "<c-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map({ "n", "t" }, "<c-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map({ "n", "t" }, "<c-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map({ "n", "t" }, "<c-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })

-- Window resize (respecting `v:count`)
map("n", "<c-Left>", '"<Cmd>vertical resize -" . v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = "Decrease window width" })
map("n", "<c-Down>", '"<Cmd>resize -"          . v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = "Decrease window height" })
map("n", "<c-Up>", '"<Cmd>resize +"          . v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = "Increase window height" })
map("n", "<c-Right>", '"<Cmd>vertical resize +" . v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = "Increase window width" })

-- Window split
map("n", "<c-w>\\", "<cmd>wincmd v<cr>", { desc = "Split window right" })
-- map("n", "<c-bslash>", "<cmd>wincmd v<cr>", { desc = "Split window right" })
map("n", "<c-w>-", "<cmd>wincmd s<cr>", { desc = "Split window below" })
-- map("n", "<c-m>", "<cmd>wincmd s<cr>", { desc = "Split window below" }) -- same as <c-minus>

-- Move cursor
map({ "i", "t", "c" }, "<a-h>", "<left>", { desc = "Cursor left", remap = true })
map({ "i", "t", "c" }, "<a-l>", "<right>", { desc = "Cursor right", remap = true })
map({ "i", "t", "c" }, "<a-j>", "<down>", { desc = "Cursor down", remap = true })
map({ "i", "t", "c" }, "<a-k>", "<up>", { desc = "Cursor up", remap = true })

-- Move Lines
map("n", "<a-s-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<a-s-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<a-s-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<a-s-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<a-s-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<a-s-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Lazy Plugin Manager
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Press gx to open the link under the cursor
map("n", "gx", ":sil !open <cWORD><cr>")

-- Highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- Toggle Options
map("n", "<localleader>b", '<Cmd>lua vim.o.bg = vim.o.bg == "dark" and "light" or "dark"; print(vim.o.bg)<CR>',
  { desc = "Toggle 'background'" })
map("n", "<localleader>c", "<Cmd>setlocal cursorline! cursorline?<CR>", { desc = "Toggle 'cursorline'" })
map("n", "<localleader>C", "<Cmd>setlocal cursorcolumn! cursorcolumn?<CR>", { desc = "Toggle 'cursorcolumn'" })
map("n", "<localleader>d", "<Cmd>lua print(MiniBasics.toggle_diagnostic())<CR>", { desc = "Toggle diagnostic" })
map("n", "<localleader>h", '<Cmd>let v:hlsearch = 1 - v:hlsearch | echo (v:hlsearch ? "  " : "no") . "hlsearch"<CR>',
  { desc = "Toggle search highlight" })
map("n", "<localleader>i", "<Cmd>setlocal ignorecase! ignorecase?<CR>", { desc = "Toggle 'ignorecase'" })
map("n", "<localleader>l", "<Cmd>setlocal list! list?<CR>", { desc = "Toggle 'list'" })
map("n", "<localleader>n", "<Cmd>setlocal number! number?<CR>", { desc = "Toggle 'number'" })
map("n", "<localleader>r", "<Cmd>setlocal relativenumber! relativenumber?<CR>", { desc = "Toggle 'relativenumber'" })
map("n", "<localleader>s", "<Cmd>setlocal spell! spell?<CR>", { desc = "Toggle 'spell'" })
map("n", "<localleader>w", "<Cmd>setlocal wrap! wrap?<CR>", { desc = "Toggle 'wrap'" })

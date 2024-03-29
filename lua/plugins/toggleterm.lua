local map=require('config').map_keys

map('n',"<leader>tf", "<cmd>ToggleTerm direction=float<cr>",      {desc = "Toggle Float Terminal" })
map('n',"<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", {desc = "Toggle Horizontal Terminal", })
map('n',"<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>",   {desc = "Toggle Vertical Terminal", })
map('n',"<leader>tt", "<cmd>ToggleTerm direction=tab<cr>",        {desc = "Toggle Tab Terminal" })
map('t',"<c-n>",      [[<c-\><c-n>]],                             {desc = "Normal Mode", buffer = 0 })

local opts = {
  shade_terminals = false,
  open_mapping = [[<c-t>]],
  direction = "horizontal",
  float_opts = {
    border = "curved",
    width = math.floor(vim.o.columns * .8),
    height = math.floor(vim.o.lines * .6),
  },
}

require('toggleterm').setup(opts)

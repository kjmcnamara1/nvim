local map=require('config').map_keys

map('n',"<leader>bb", "<cmd>BufferLinePick<cr>",                                 {desc = "Pick buffer" })
map('n',"<leader>x",  "<cmd>BufferLinePickClose<cr>",                            {desc = "Pick buffer to close" })
map('n',"<leader>bp", "<cmd>BufferLineTogglePin<cr>",                            {desc = "Toggle pin" })
map('n',"<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>",                 {desc = "Delete non-pinned buffers" })
map('n',"<leader>bo", "<cmd>BufferLineCloseOthers<cr>",                          {desc = "Delete other buffers" })
map('n',"<leader>bl", "<cmd>BufferLineMoveNext<cr>",                             {desc = "Move buffer right" })
map('n',"<leader>bh", "<cmd>BufferLineMovePrev<cr>",                             {desc = "Move buffer left" })
map('n',"<a-h>",      "<cmd>BufferLineCyclePrev<cr>",                            {desc = "Prev buffer" })
map('n',"<a-l>",      "<cmd>BufferLineCycleNext<cr>",                            {desc = "Next buffer" })
map('n',"[b",         "<cmd>BufferLineCyclePrev<cr>",                            {desc = "Prev buffer" })
map('n',"]b",         "<cmd>BufferLineCycleNext<cr>",                            {desc = "Next buffer" })
map({ "n", "i", "v" },"<c-x>",      function() require("mini.bufremove").delete(0, false) end, {desc = "Quit Buffer", })

local opts={
  options = {
    diagnostics = "nvim_lsp",
    always_show_bufferline = true,
    hover = {
      enabled = true,
      delay = 200,
      reveal = { "close" },
    },
    offsets = {
      {
        filetype = "neo-tree",
        text = "Neo-tree",
        highlight = "Directory",
        text_align = "left",
      },
    },
    close_command = function(n)
      require("mini.bufremove").delete(n, false)
    end,
    right_mouse_command = function(n)
      require("mini.bufremove").delete(n, false)
    end,
  },
}

require('bufferline').setup(opts)

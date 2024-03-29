local map=require('config').map_keys

map('n',"<leader>dd", "<cmd>TroubleToggle<cr>",                       {desc = "Toggle Trouble" })
map('n',"<leader>dw", "<cmd>TroubleToggle workspace_diagnostics<cr>", {desc = "Workspace Diagnostics" })
map('n',"<leader>dD", "<cmd>TroubleToggle document_diagnostics<cr>",  {desc = "Document Diagnostics" })
map('n',"<leader>dq", "<cmd>TroubleToggle quickfix<cr>",              {desc = "QuickFix List" })
map('n',"<leader>dl", "<cmd>TroubleToggle loclist<cr>",               {desc = "Location List" })
map('n',"gd",         "<cmd>TroubleToggle lsp_definitions<cr>",       {desc = "LSP Definitions" })
map('n',"gr",         "<cmd>TroubleToggle lsp_references<cr>",        {desc = "LSP References" })
map('n',"gt",         "<cmd>TroubleToggle lsp_type_definitions<cr>",  {desc = "LSP Type Definitions" })

local opts={
  padding = false,
  multiline = false,
  win_config = { border = "rounded" },
  signs = { error = " ", warning = " ", information = " ", hint = "󰠠 ", other = " " }
}

require('trouble').setup(opts)

if profile() ~= "default" then
  return
end

vim.pack.add({
  "https://github.com/nvim-mini/mini.files",
  "https://github.com/mikavilpas/yazi.nvim",
})

wk.add({
  { "<leader>m", "<cmd>lua MiniFiles.open()<cr>",                             desc = "Files: Mini" },
  { "<leader>M", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>", desc = "Files: Mini (current)" },
  { "<leader>y", "<cmd>Yazi toggle<cr>",                                      desc = "Files: Yazi" },
})

require("mini.files").setup({
  windows = {
    preview = true,
    width_focus = 40,
    width_preview = 30,
  },
  mappings = {
    close = "<esc>",
    synchronize = "<cr>",
  },
  options = { use_as_default_explorer = false },
})

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesActionRename",
  callback = function(event)
    Snacks.rename.on_rename_file(event.data.from, event.data.to)
  end,
})

require("yazi").setup({
  open_multiple_tabs = true,
  yazi_floating_window_border = 'none',
})

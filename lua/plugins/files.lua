return {

  {
    "echasnovski/mini.files",
    cond = profile() == "default",
    keys = {
      { "<leader>m", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>", desc = "Files: Mini (current)" },
      { "<leader>M", "<cmd>lua MiniFiles.open()<cr>",                             desc = "Files: Mini" },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
          Snacks.rename.on_rename_file(event.data.from, event.data.to)
        end,
      })
    end,
    opts = {
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
    },
  },

  {

    "mikavilpas/yazi.nvim",
    cond = profile() == "default",
    event = "VeryLazy",
    keys = {
      { "<leader>y", "<cmd>Yazi toggle<cr>", desc = "Files: Yazi" },
    },
    opts = {
      open_multiple_tabs = true,
      yazi_floating_window_border = 'none',
    },

  }

}

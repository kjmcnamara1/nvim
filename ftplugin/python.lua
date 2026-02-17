pack_add({
  "https://github.com/linux-cultist/venv-selector.nvim",
  "https://codeberg.org/mfussenegger/nvim-dap-python",
})

wk.add({
  "<leader>cv",
  "<cmd>VenvSelect<cr>",
  desc = "Select VirtualEnv",
  cond = function()
    return vim.bo.filetype == "python"
  end,
})

require("venv-selector").setup({ settings = { options = { notify_user_on_venv_activation = true } } })
require("dap-python").setup("uv")

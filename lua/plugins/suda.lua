local function save_w_prompt(opts)
  local buf_name = vim.api.nvim_buf_get_name(0)
  local cmd_prefix = opts and opts.noautocmd and "noautocmd " or ""

  if buf_name == "" then
    vim.ui.input({ prompt = "Save as: " }, function(input)
      if not input or input == "" then
        return
      end
      vim.cmd(cmd_prefix .. "write! ++p " .. input)
    end)
  else
    vim.cmd(cmd_prefix .. "write! ++p")
  end
end

return {
  "lambdalisue/vim-suda",
  lazy = false,
  cmd = { "SudaRead", "SudaWrite" },
  keys = {
    mode = { "n", "x" },
    { "<c-s>",   function() save_w_prompt() end,                     desc = "Save file" },
    { "<c-s-s>", function() save_w_prompt({ noautocmd = true }) end, desc = "Save w/o formatting" },
    -- { "<c-s>",   "<cmd>w! ++p<cr>",           desc = "Save file" },
    -- { "<c-s-s>", "<cmd>noautocmd w! ++p<cr>", desc = "Save w/o formatting" },
  },
  init = function()
    vim.g.suda_smart_edit = 1
  end
}

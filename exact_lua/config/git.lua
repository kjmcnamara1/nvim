if profile() ~= "default" then
  return
end

vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim",
  -- "https://github.com/MunifTanjim/nui.nvim",
  -- "https://github.com/clabby/difftastic.nvim",
})

wk.add({
  { "<leader>hi", ":Gitsigns preview_hunk_inline<cr>", desc = "Git Hunk: Inline Preview", mode = { 'n', 'x' } },
  { "<leader>hs", ":Gitsigns stage_hunk<cr>",          desc = "Git Hunk: Stage",          mode = { 'n', 'x' } },
  { "<leader>hu", ":Gitsigns undo_stage_hunk<cr>",     desc = "Git Hunk: Undo Stage",     mode = { 'n', 'x' } },
  { "<leader>hr", ":Gitsigns reset_hunk<cr>",          desc = "Git Hunk: Reset",          mode = { 'n', 'x' } },
  { 'ih',         ":<c-u>Gitsigns select_hunk<cr>",    desc = "Git Hunk: Text Object",    mode = { "o", "x" } },
  {
    ']h',
    function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        require("gitsigns").nav_hunk('next')
      end
    end,
    desc = "Next Hunk"
  },
  {
    '[h',
    function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        require("gitsigns").nav_hunk('prev')
      end
    end,
    desc = "Previous Hunk"
  },
})

require("gitsigns").setup({
  current_line_blame = true,
  current_line_blame_opts = {
    ignore_whitespace = true
  },
})

-- require("difftastic-nvim").setup({
--   download = true, -- Auto-download pre-built binary
-- })

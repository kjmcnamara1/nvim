return {

  {
    "lewis6991/gitsigns.nvim",
    cond = profile() == "default",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    keys = {
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
    },
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        ignore_whitespace = true
      },
    },
  },

  {
    "sindrets/diffview.nvim",
    cond = profile() == "default",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh", "DiffviewFileHistory" },
    opts = {},
  },

  {
    "clabby/difftastic.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- optional: only needed for :DifftPick
      -- "folke/snacks.nvim",
    },
    cond = profile() == "default",
    cmd = { "Difft", "DifftPick", "DifftPickRange", "DifftClose", "DifftUpdate" },
    opts = {
      download = true, -- Auto-download pre-built binary
      vcs = "git",
      snacks_picker = {
        enabled = true,
      },
      keymaps = {
        next_hunk = "]h",
        prev_hunk = "[h",
      }
    },
  },

}

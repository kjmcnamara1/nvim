return {
  { "echasnovski/mini.surround",config=true, },
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
--       opts = {
--         enable_autocmd = false,
--       },
    },
    opts = {
      ignore = "^%s*$", -- Ignore blank lines
--       pre_hook = function()
--         require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
--       end,
    },
--     keys = {
--       { "<c-_>", function() require("Comment.api").toggle.linewise.current() end, mode = "i", desc = "Toggle comment" },
--     },
  },
  {
    "folke/flash.nvim",
--     keys = {
--       { "f", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
--       { "F", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Trweesitter", },
--       { "r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash", },
--       { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search", },
--     },
    opts = {
      jump = {
        autojump = true,
      },
      label = {
        current = false,
      },
      modes = {
        search = { enabled = false },
        char = { enabled = false },
      },
    },
  },
  {
    "vscode-neovim/vscode-multi-cursor.nvim",
    cond = not not vim.g.vscode,
    opts = { no_selection = true },
  }
}

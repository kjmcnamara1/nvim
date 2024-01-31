return {
  {
    "akinsho/toggleterm.nvim",
    opts = {
      shade_terminals = false,
      open_mapping = [[<c-\>]],
      direction = "horizontal",
      winbar = {
        enabled = true,
      },
      float_opts = {
        border = "curved",
        width = 120,
        height = 30,
      },
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        else
          return 20
        end
      end,
    },
    -- config = function (_,opts)
    --   require('toggleterm').setup(opts)
    --
    -- end
    cmd = "ToggleTerm",
    keys = {
      {
        "<c-bslash>",
        -- "<cmd>ToggleTerm<cr>",
        mode = { "i", "n", "t" },
        desc = "Toggle Terminal",
      },
      {
        "<c-t>f",
        "<cmd>ToggleTerm direction=float<cr>",
        mode = { "i", "n", "t" },
        desc = "Toggle Float Terminal",
      },
      {
        "<c-t>h",
        "<cmd>ToggleTerm direction=horizontal<cr>",
        mode = { "i", "n", "t" },
        desc = "Toggle Horizontal Terminal",
      },
      {
        "<c-t>v",
        "<cmd>ToggleTerm direction=vertical<cr>",
        mode = { "i", "n", "t" },
        desc = "Toggle Vertical Terminal",
      },
      {
        "<c-t>t",
        "<cmd>ToggleTerm direction=tab<cr>",
        mode = { "i", "n", "t" },
        desc = "Toggle Tab Terminal",
      },
      { "<c-x>", [[<c-\><c-n>]], mode = "t", buffer = 0 },
    },
  },
  -- {
  --   "NvChad/nvterm",
  --   config = function()
  --     require("nvterm").setup()
  --     local terminal = require("nvterm.terminal")
  --     vim.keymap.set({ "n", "t" }, "<c-i>", function()
  --       terminal.toggle("float")
  --     end, { noremap = true, silent = true, desc = "Toggle floating terminal" })
  --   end,
  --   -- keys = {
  --   --   { '<c-i>', function() require('nvterm.terminal').toggle('float') end, mode = { 'n', 't' }, desc = 'Toggle Terminal' }
  --   -- },
  -- },
}

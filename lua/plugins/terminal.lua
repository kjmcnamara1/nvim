return {
  {
    "declancm/windex.nvim",
    enabled = false,
    cond = not vim.g.vscode,
    keys = {
      { "<F3>",  function() require("windex").toggle_maximize() end,      desc = "Toggle Maximize Current Window" },
      { "<c-h>", function() require("windex").switch_window("left") end,  desc = "Switch to Left Window" },
      { "<c-j>", function() require("windex").switch_window("down") end,  desc = "Switch to Lower Window" },
      { "<c-k>", function() require("windex").switch_window("up") end,    desc = "Switch to Upper Window" },
      { "<c-l>", function() require("windex").switch_window("right") end, desc = "Switch to Right Window" },
      { "<c-G>", function() require("windex").previous_window() end,      desc = "Switch to Previous Window" }, -- same as <c-'>
      { "<c-t>", function() require("windex").toggle_terminal() end,      desc = "Toggle Terminal",               mode = { "n", "t" } },
      { "<c-n>", [[<c-\><c-n>]],                                          desc = "Normal Mode",                   mode = "t" },
    },
    opts = {
      default_keymaps = false,
    },
  },
  {
    "akinsho/toggleterm.nvim",
    cond = not vim.g.vscode,
    cmd = "ToggleTerm",
    keys = {
      {
        "<c-t>",
        -- "<cmd>ToggleTerm<cr>",
        mode = { "n", "t" },
        desc = "Toggle Terminal",
      },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",      desc = "Toggle Float Terminal" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle Horizontal Terminal", },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>",   desc = "Toggle Vertical Terminal", },
      { "<leader>tt", "<cmd>ToggleTerm direction=tab<cr>",        desc = "Toggle Tab Terminal" },
      { "<c-n>",      [[<c-\><c-n>]],                             desc = "Normal Mode",                mode = "t", buffer = 0 },
      { "<F5>", function()
        vim.cmd.write()
        local cmds = {
          python = require("venv-selector").python() or "python",
        }
        local prg = cmds[vim.bo.filetype] or ""
        local cmd = (prg and (prg .. " ") or "") .. vim.api.nvim_buf_get_name(0)
        require("toggleterm").exec(cmd)
        -- vim.cmd.startinsert()
      end },
    },
    opts = {
      shade_terminals = false,
      open_mapping = [[<c-t>]],
      direction = "horizontal",
      persist_size = false,
      -- winbar = {
      --   enabled = true,
      -- },
      float_opts = {
        border = "curved",
        width = math.floor(vim.o.columns * .8),
        height = math.floor(vim.o.lines * .6),
      },
      -- size = function(term)
      --   if term.direction == "horizontal" then
      --     return math.max(math.floor(vim.o.lines * .3), 10)
      --   elseif term.direction == "vertical" then
      --     return math.max(math.floor(vim.o.columns * 0.4), 40)
      --   else
      --     return 20
      --   end
      -- end,
    },
  },
  {
    "willothy/flatten.nvim",
    -- enabled = false,
    cond = not vim.g.vscode,
    ft = "toggleterm",
    opts = {
      window = {
        open = "alternate",
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
}

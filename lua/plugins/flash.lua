return {
  "folke/flash.nvim",
  event = "VeryLazy",
  keys = {
    { "s",     function() require("flash").jump() end,              desc = "Flash: Jump",               mode = { "n", "o", "x" } },
    { "S",     function() require("flash").treesitter() end,        desc = "Flash: Treesitter",         mode = { "n", "o" } },
    { "r",     function() require("flash").remote() end,            desc = "Remote Flash",              mode = { "o" } },
    { "R",     function() require("flash").treesitter_search() end, desc = "Treesitter Search",         mode = { "o", "x" } },
    { "<a-s>", function() require("flash").toggle() end,            desc = "Flash: Toggle Search Mode", mode = { "c" } },
    {
      "\\",
      function()
        require("flash").jump({
          highlight = { backdrop = false },
          search = { mode = "fuzzy", incremental = vim.o.incsearch },
          jump = { history = true, register = true, nohlsearch = false, autojump = false },
        })
      end,
      desc = "Fuzzy search",
      mode = { "n" }
    },
  },
  opts = {
    jump = { autojump = false },
    label = { current = false },
    search = {
      exclude = {
        "notify",
        "cmp_menu",
        "blink-cmp-menu",
        "noice",
        "flash_prompt",
        function(win)
          -- exclude non-focusable windows
          return not vim.api.nvim_win_get_config(win).focusable
        end,
      },
    },
    modes = {
      search = { enabled = true },
      treesitter = {
        label = {
          style = "overlay",
          rainbow = {
            enabled = true
          }
        }
      },
      treesitter_search = {
        label = {
          style = "overlay",
          rainbow = {
            enabled = true
          }
        }
      },
      char = {
        keys = {
          "f",
          "F",
          "t",
          "T",
          [";"] = "<a-.>",   -- next
          [","] = "<a-s-;>", -- prev (alt-:)
        },
      },
    }
  }
}

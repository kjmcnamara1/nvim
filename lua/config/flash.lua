pack_add({ "https://github.com/folke/flash.nvim" })

require("flash").setup({
  jump = { autojump = true },
  label = { current = false },
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
})

wk.add({
  { "s",     require("flash").jump,              desc = "Flash: Jump",               mode = { "n", "o", "x" } },
  { "S",     require("flash").treesitter,        desc = "Flash: Treesitter",         mode = { "n", "o" } },
  { "r",     require("flash").remote,            desc = "Remote Flash",              mode = { "o" } },
  { "R",     require("flash").treesitter_search, desc = "Treesitter Search",         mode = { "o", "x" } },
  { "<a-s>", require("flash").toggle,            desc = "Flash: Toggle Search Mode", mode = { "c" } },
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
})

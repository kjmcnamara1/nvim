local map=require('config').map_keys

local opts={
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
  autopairs = { enable = true },
  autotag = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<c-space>",
      node_incremental = "<c-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
  textobjects = {
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]c"] = "@comment.outer",
        ["]a"] = "@parameter.inner",
        ["]m"] = "@function.outer",
        ["]f"] = "@call.outer",
        ["]C"] = "@class.outer",
        ["]="] = "@assignment.inner",
        ["]l"] = "@loop.outer",
        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
        -- ["]z"] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
        -- ["<tab>"] = {query={'@variable*','@attribute.inner*','@parameter.inner','@assignment.inner','@conditional.inner','@call.inner'}},
      },
      -- goto_next_end = {
      --   [']C'] = '@comment.outer',
      --   [']A'] = '@parameter.outer',
      --   ["]F"] = "@function.outer",
      --   ["]["] = "@class.outer"
      -- },
      goto_previous_start = {
        ["[c"] = "@comment.outer",
        ["[a"] = "@parameter.inner",
        ["[m"] = "@function.outer",
        ["[f"] = "@call.outer",
        ["[C"] = "@class.outer",
        ["[="] = "@assignment.inner",
        ["[l"] = "@loop.outer",
        ["[s"] = { query = "@scope", query_group = "locals", desc = "Previous scope" },
        -- ["[z"] = { query = '@fold', query_group = 'folds', desc = 'Previous fold' },
        -- ["<s-tab>"] = {query={'@variable*','@attribute.inner*','@parameter.inner','@assignment.inner','@conditional.inner','@call.inner'}},
      },
      -- goto_previous_end = {
      --   ['[C'] = '@comment.outer',
      --   ['[A'] = '@parameter.outer',
      --   ["[F"] = "@function.outer",
      --   ["[]"] = "@class.outer"
      -- },
      -- goto_next = {[']c'] = '@comment.outer'},
      -- goto_previous = {['[c'] = '@comment.outer'},
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>na"] = "@parameter.inner",
        ["<leader>nm"] = "@function.outer",
      },
      swap_previous = {
        ["<leader>pa"] = "@parameter.inner",
        ["<leader>pm"] = "@function.outer",
      },
    },
  },
}

require('nvim-treesitter.configs').setup(opts)

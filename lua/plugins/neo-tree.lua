return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  opts = {
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
    window = {
      mappings = {
        ["<space>"] = "none",
        ["<tab>"] = "toggle_node",
        ["Z"] = "expand_all_nodes",
      },
    },
    filesystem = {
      group_empty_dirs = true,
      hijack_netrw_behavior = "open_default",
      -- follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      window = {
        position = 'left',
        fuzzy_finder_mappings = {
          ['<c-n>'] = 'move_cursor_down',
          ['<c-p>'] = 'move_cursor_up',
        },
      }
    },
    buffers = {
      follow_current_file = {
        enabled = true,
      },
      show_unloaded = true,
    },
    document_symbols = {
      window = {
        position = 'right',
      }
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
    },
  },
  keys = {
    {
      "<leader>e",
      ":Neotree toggle reveal<cr>",
      desc = "NeoTree Explorer",
      silent = true,
    },
    {
      "<leader>ge",
      ":Neotree toggle reveal source=git_status<cr>",
      desc = "NeoTree Git Explorer",
      silent = true,
    },
    {
      "<leader>oe",
      ":Neotree toggle reveal source=document_symbols<cr>",
      desc = "NeoTree Symbols Outline",
      silent = true,
    },
    {
      "<leader>be",
      ":Neotree toggle reveal source=buffers<cr>",
      desc = "NeoTree Buffers",
      silent = true,
    },
  },
  init = function()
    if vim.fn.argc(-1) == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("neo-tree")
      end
    end
  end,
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
}

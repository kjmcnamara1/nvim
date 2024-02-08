return {
  -- ====================================== COLORSCHEMES ======================================
  -- ============================================ UI ============================================
  -- {
  --   "nvimdev/dashboard-nvim",
  --   event = "VimEnter",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   opts = function()
  --     local logo = [[
  --       ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
  --       ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
  --       ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
  --       ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
  --       ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
  --       ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
  --     ]]
  --     logo = string.rep("\n", 8) .. logo .. "\n\n"

  --     local opts = {
  --       theme = "doom",
  --       config = {
  --         header = vim.split(logo, "\n"),
  --         center = {
  --           { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
  --           { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
  --           { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
  --           { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
  --           {
  --             action = [[lua require("telescope.builtin").find_files({cwd = vim.fn.stdpath("config")})]],
  --             desc = " Config",
  --             icon = " ",
  --             key = "c",
  --           },
  --           { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
  --           -- { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
  --           { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
  --           { action = "qa", desc = " Quit", icon = " ", key = "q" },
  --         },
  --         footer = function()
  --           local stats = require("lazy").stats()
  --           local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
  --           return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
  --         end,
  --       },
  --     }

  --     for _, button in ipairs(opts.config.center) do
  --       button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
  --       button.key_format = "  %s"
  --     end

  --     -- close Lazy and re-open when the dashboard is ready
  --     if vim.o.filetype == "lazy" then
  --       vim.cmd.close()
  --       vim.api.nvim_create_autocmd("User", {
  --         pattern = "DashboardLoaded",
  --         callback = function()
  --           require("lazy").show()
  --         end,
  --       })
  --     end

  --     return opts
  --   end,
  -- },
  -- TODO: Need to clean up new terminal command keymaps
  
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufEnter",
    cond = (vim.env.NAME or vim.env.COMPUTERNAME) ~= 'ANGEL',
    opts = {
      indent = {
        char = "",
        tab_char = "│",
      },
      whitespace = {
        highlight = {
          "CursorColumn",
          "Whitespace",
        },
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },
  -- {
  --   "stevearc/dressing.nvim",
  --   opts = {
  --     input = {
  --       insert_only = false,
  --     },
  --   },
  -- },
  -- {
  --   "j-hui/fidget.nvim",
  --   opts = {
  --     -- options
  --   },
  -- },
  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     lsp = {
  --       override = {
  --         ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --         ["vim.lsp.util.stylize_markdown"] = true,
  --         ["cmp.entry.get_documentation"] = true,
  --       },
  --     },
  --     routes = {
  --       {
  --         filter = {
  --           event = "msg_show",
  --           any = {
  --             { find = "%d+L, %d+B" },
  --             { find = "; after #%d+" },
  --             { find = "; before #%d+" },
  --           },
  --         },
  --         view = "mini",
  --       },
  --     },
  --     presets = {
  --       -- bottom_search = true,
  --       command_palette = true,
  --       -- long_message_to_split = true,
  --       inc_rename = true,
  --       lsp_doc_border = true,
  --     },
  --   },
  --   keys = {
  --     {
  --       "<S-Enter>",
  --       function()
  --         require("noice").redirect(vim.fn.getcmdline())
  --       end,
  --       mode = "c",
  --       desc = "Redirect Cmdline",
  --     },
  --     {
  --       "<leader>snl",
  --       function()
  --         require("noice").cmd("last")
  --       end,
  --       desc = "Noice Last Message",
  --     },
  --     {
  --       "<leader>snh",
  --       function()
  --         require("noice").cmd("history")
  --       end,
  --       desc = "Noice History",
  --     },
  --     {
  --       "<leader>sna",
  --       function()
  --         require("noice").cmd("all")
  --       end,
  --       desc = "Noice All",
  --     },
  --     {
  --       "<leader>snd",
  --       function()
  --         require("noice").cmd("dismiss")
  --       end,
  --       desc = "Dismiss All",
  --     },
  --     {
  --       "<c-f>",
  --       function()
  --         if not require("noice.lsp").scroll(4) then
  --           return "<c-f>"
  --         end
  --       end,
  --       silent = true,
  --       expr = true,
  --       desc = "Scroll forward",
  --       mode = { "i", "n", "s" },
  --     },
  --     {
  --       "<c-b>",
  --       function()
  --         if not require("noice.lsp").scroll(-4) then
  --           return "<c-b>"
  --         end
  --       end,
  --       silent = true,
  --       expr = true,
  --       desc = "Scroll backward",
  --       mode = { "i", "n", "s" },
  --     },
  --   },
  --   dependencies = {
  --     "rcarriga/nvim-notify",
  --     keys = {
  --       {
  --         "<leader>un",
  --         function()
  --           require("notify").dismiss({ silent = true, pending = true })
  --         end,
  --         desc = "Dismiss all Notifications",
  --       },
  --     },
  --     opts = {
  --       timeout = 3000,
  --       max_height = function()
  --         return math.floor(vim.o.lines * 0.75)
  --       end,
  --       max_width = function()
  --         return math.floor(vim.o.columns * 0.75)
  --       end,
  --       on_open = function(win)
  --         vim.api.nvim_win_set_config(win, { zindex = 100 })
  --       end,
  --     },
  --   },
  -- },

  -- ============================================ EDITOR ============================================
  {
    -- Adds labels for marks to sign column and several keymaps
    'kshenoy/vim-signature',
    event={'BufReadPost','BufNewFile'},
  },
  {
    "echasnovski/mini.indentscope",
    event = "VeryLazy",
    opts = {
      symbol = "▏",
      -- symbol = "│",
      draw = {
        animation = function()
          return 0
        end,
      },
      options = {
        try_as_border = true,
      },
    },
    init = function()
      -- Automatically disable mini.indentscope for certain filetypes
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- ============================================ EDITING ============================================
  {
    "echasnovski/mini.basics",  
    event = "VeryLazy",
    opts = {
      options = {
        extra_ui = true,
      },
      mappings = {
        windows = true,
      },
    },
  },
  -- {
  --   "echasnovski/mini.pairs",
  --   event = "VeryLazy",
  --   config = true,
  -- },
  {
    "echasnovski/mini.cursorword",
    event = "VeryLazy",
    config = true,
  },
  {
    "echasnovski/mini.surround",
    keys = { 
      { 'sa',desc='Add surrounding', mode={'n','x'} },
      { 'sd',desc='Delete surrounding',  },
      { 'sr',desc='Replace surrounding',  },
      { 'sh',desc='Highlight surrounding',  },
      { 'sf',desc='Find right surrounding',  },
      { 'sF',desc='Find left surrounding',  },
      { 'sn',desc='Update `MiniSurround.config.n_lines`',  },
    },
    config=true,
    init=function()
      vim.keymap.set('n','s','<nop>')
    end,
  },



  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    -- init = function()
    --   vim.o.timeout=true
    --   vim.o.timeoutlen=300
    -- end,
  },
}

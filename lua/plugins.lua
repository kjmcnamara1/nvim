return {
  -- ====================================== COLORSCHEMES ======================================
  {
    "rmehri01/onenord.nvim",
    name = "onenord",
    event = "VimEnter",
    priority = 1000,
    opts = {
      fade_nc = true,
      styles = {
        comments = "italic",
        keywords = "bold",
      },
      -- TODO: Need to add override for Neo-tree focused file 'NeoTreeCursorLine'
    },
  },
  {
    "shaunsingh/nord.nvim",
    name = "nord",
    event = "VeryLazy",
  },
  {
    "olimorris/onedarkpro.nvim",
    name = "onedarkpro",
    event = "VeryLazy",
  },
  {
    "navarasu/onedark.nvim",
    name = "onedark",
    event = "VeryLazy",
  },
  {
    "neanias/everforest-nvim",
    name = "everforest",
    event = "VeryLazy",
    version = false,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    event = "VeryLazy",
  },

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
  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    opts = {
      options = {
        globalstatus = true,
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "echasnovski/mini.bufremove", -- Better algorithm for display after closing a buffer
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        -- separator_style = 'slope',
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
        close_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
        right_mouse_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
      },
    },
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
      -- { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
      -- { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
      { "<a-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<a-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "<leader>x", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer", },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd("BufAdd", {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },
  {
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
        follow_current_file = { 
          enabled = true,
          leave_dirs_open=true,
        },
        use_libuv_file_watcher = true,
        window = {
          position = "left",
          fuzzy_finder_mappings = {
            ["<c-n>"] = "move_cursor_down",
            ["<c-p>"] = "move_cursor_up",
          },
        },
      },
      buffers = {
        show_unloaded = true,
      },
      document_symbols = {
        window = {
          position = "right",
        },
      },
    },
    keys = {
      { "<leader>e", ":Neotree toggle reveal<cr>", desc = "NeoTree Explorer", silent = true, },
      { "<leader>ge", ":Neotree toggle reveal source=git_status<cr>", desc = "NeoTree Git Explorer", silent = true, },
      { "<leader>oe", ":Neotree toggle reveal source=document_symbols<cr>", desc = "NeoTree Symbols Outline", silent = true, },
      { "<leader>be", ":Neotree toggle reveal source=buffers<cr>", desc = "NeoTree Buffers", silent = true, },
    },
  },
  -- TODO: Need to clean up new terminal command keymaps
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    opts = {
      shade_terminals = false,
      open_mapping = [[<c-\>]],
      direction = "float",
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
    keys = {
      {
        "<c-bslash>",
        -- "<cmd>ToggleTerm<cr>",
        mode = { "i", "n", "t" },
        desc = "Toggle Terminal",
        },
        { "<c-t>f", "<cmd>ToggleTerm direction=float<cr>", mode = { "i", "n", "t" }, desc = "Toggle Float Terminal" },
        { "<c-t>h", "<cmd>ToggleTerm direction=horizontal<cr>", mode = { "i", "n", "t" }, desc = "Toggle Horizontal Terminal", },
        { "<c-t>v", "<cmd>ToggleTerm direction=vertical<cr>", mode = { "i", "n", "t" }, desc = "Toggle Vertical Terminal", },
        { "<c-t>t", "<cmd>ToggleTerm direction=tab<cr>", mode = { "i", "n", "t" }, desc = "Toggle Tab Terminal" },
        { "<c-x>", [[<c-\><c-n>]], mode = "t", buffer = 0 },
      },
    },
  
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    cmd = 'Neogit',
    keys = {
      {'<leader>gg','<cmd>Neogit<cr>',desc = 'Open NeoGit'}
    },
    opts = {
      graph_style  ='unicode',
      telescope_sorter = function()
        return require("telescope").extensions.fzf.native_fzf_sorter()
      end,
      signs = {
        -- { CLOSED, OPENED }
        section = { "󰧚", "󰧗" },
        item = { "󰬪", "󰬧" },
        hunk = { "󰅂", "󰅀" },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      preview_config = {
        border = "rounded",
      },
    },
    keys = {
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Git Preview Hunk" ,buffer=0},
      { "<leader>gi", "<cmd>Gitsigns preview_hunk_inline<cr>", desc = "Git Preview Hunk Inline" ,buffer=0},
      { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle Git Blame",buffer=0 },
      { "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", desc = "Git Stage Buffer",buffer=0 },
      { "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", desc = "Git Reset Buffer",buffer=0 },
      -- Git Hunks
      { "<leader>ghs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage Git Hunk",buffer=0 },
      { "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset Git Hunk",buffer=0 },
      { "<leader>ghu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo Stage Git Hunk",buffer=0 },
      -- Movements
      { "]h", "<cmd>Gitsigns next_hunk<cr>", desc = "Next Git Hunk",buffer=0 },
      { "[h", "<cmd>Gitsigns prev_hunk<cr>", desc = "Previous Git Hunk",buffer=0 },
      -- Text Object
      { "ih", ":<c-u>Gitsigns select_hunk<cr>", mode={'o','x'},desc = "Previous Git Hunk",buffer=0 },
      { "ah", ":<c-u>Gitsigns select_hunk<cr>", mode={'o','x'},desc = "Previous Git Hunk",buffer=0 },
    },
  },
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
  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },
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
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { 
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
      }
    },
    cmd = "Telescope",
    version = false,
    opts = {
      prompt_prefix = "   ",
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorder = true,
          case_mode = 'smart_case',
        }
      }
    },
    config = function (_,opts)
      require('telescope').setup(opts)
      require("telescope").load_extension("fzf")
    end,
    keys = {
      -- common
      { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true theme=dropdown<cr>", desc = "Buffers" },
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>r", "<cmd>Telescope oldfiles theme=dropdown<cr>", desc = "Find Recent" },
      -- { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Git-files" },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
      -- search
      { '<leader>"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
      { "<leader>*", "<cmd>Telescope grep_string<cr>", desc = "Grep Word under cursor" },
      { "<leader>?", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      {
        "<leader>uC",
        function()
          require("telescope.builtin").colorscheme({ enable_preview = true })
        end,
        desc = "Colorscheme with preview",
      },
    },
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
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      -- "nushell/tree-sitter-nu" ,
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    event={'BufReadPost','BufNewFile','VeryLazy'},
    cmd = { "TSInstall",'TSBufEnable','TSBufDisable','TSModuleInfo',"TSUpdateSync", "TSUpdate",  },
    keys = {
      {';',function() return require('nvim-treesitter.textobjects.repeatable_move').repeat_last_move_next() end, mode={'n','x','o'}, desc='Repeat next move'},
      {',',function() return require('nvim-treesitter.textobjects.repeatable_move').repeat_last_move_previous() end, mode={'n','x','o'}, desc='Repeat previous move'},
      {'f',function() return require('nvim-treesitter.textobjects.repeatable_move').builtin_f() end, mode={'n','x','o'},desc='Find character forwards'},
      {'F',function() return require('nvim-treesitter.textobjects.repeatable_move').builtin_F() end, mode={'n','x','o'},desc='Find character backwards'},
      {'t',function() return require('nvim-treesitter.textobjects.repeatable_move').builtin_t() end, mode={'n','x','o'},desc='Until character forwards'},
      {'T',function() return require('nvim-treesitter.textobjects.repeatable_move').builtin_T() end, mode={'n','x','o'},desc='Until character backwards'},
    },
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
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
          set_jumps=true,
          goto_next_start = {
            [']c'] = '@comment.outer',
            [']a'] = '@parameter.inner',
            ["]m"] = "@function.outer", 
            ["]f"] = "@call.outer", 
            ["]C"] = "@class.outer",
            ["]="] = "@assignment.inner",
            ["]l"] = "@loop.outer",
            ["]s"] = {query='@scope',query_group='locals', desc='Next scope'},
            ["]z"] = {query='@fold',query_group='folds', desc='Next fold'},
            -- ["<tab>"] = {query={'@variable*','@attribute.inner*','@parameter.inner','@assignment.inner','@conditional.inner','@call.inner'}},
          },
          -- goto_next_end = {
          --   [']C'] = '@comment.outer',
          --   [']A'] = '@parameter.outer',
          --   ["]F"] = "@function.outer",
          --   ["]["] = "@class.outer"
          -- },
          goto_previous_start = {
            ['[c'] = '@comment.outer',
            ['[a'] = '@parameter.inner',
            ["[m"] = "@function.outer",
            ["[f"] = "@call.outer", 
            ["[C"] = "@class.outer" ,
            ["[="] = "@assignment.inner",
            ["[l"] = "@loop.outer",
            ["[s"] = {query='@scope',query_group='locals', desc='Previous scope'},
            ["[z"] = {query='@fold',query_group='folds', desc='Previous fold'},
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
          enable=true,
          swap_next={
            ['<leader>na'] = '@parameter.inner',
            ['<leader>nm'] = '@function.outer',
          },
          swap_previous = {
            ['<leader>pa'] = '@parameter.inner',
            ['<leader>pm'] = '@function.outer',
          },
        },
      },
    },
    -- init=function(plugin)
    --   require("nvim-treesitter.query_predicates")
    -- end,
    config = function(_,opts)
      require('nvim-treesitter.configs').setup(opts)
      -- vim.opt.foldmethod=exp
      -- vim.opt.foldexpr=nvim_treesitter#foldexpr()

      -- local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')
      -- vim.keymap.set({'n','x','o'}, ';',ts_repeat_move.repeat_last_move_next)
      -- vim.keymap.set({'n','x','o'}, ';',ts_repeat_move.repeat_last_move_previous)

      -- vim.keymap.set({'n','x','o'}, 'f',ts_repeat_move.builtin_f)
      -- vim.keymap.set({'n','x','o'}, 'F',ts_repeat_move.builtin_F)
      -- vim.keymap.set({'n','x','o'}, 't',ts_repeat_move.builtin_t)
      -- vim.keymap.set({'n','x','o'}, 'T',ts_repeat_move.builtin_T)
    end,
  }, 
  {    "nvim-treesitter/nvim-treesitter-context",
    event={'BufReadPost','BufNewFile'},
    opts = {
      max_lines=3,
    },
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
      options = {'buffers','curdir','tabpages','winsize','terminal','folds'}
    },
    keys = {
      {'<leader>wl',[[<cmd>lua require('persistence').load()<cr>]],desc='Restore session'}
    }
  },
  {
    "szw/vim-maximizer",
    cmd = "MaximizerToggle",
    keys = {
      { "<F3>", mode = { "i", "n", "v" }, desc = "Toggle maximize window" },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      jump = {
        autojump=true,
      },
      label={
        current=false,
      },
      modes = {
        char = { enabled=false },
      },
    },
    keys = {
      { "f",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "F", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Trweesitter", },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash", },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search", },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search", },
    },
  },
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
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = true,
  },
  {
    "echasnovski/mini.cursorword",
    event = "VeryLazy",
    config = true,
  },
  {
    "echasnovski/mini.surround",
    keys = { 'sa', 'sd', 'sn', 'sr', 'sh', 'sf', 'sF' }, 
    config = true,
  },

  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        -- TODO: Add 'gc' text object for comments
        custom_textobjects = {
          -- o = ai.gen_spec.treesitter({
          --   a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          --   i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          -- }),
          ['='] = ai.gen_spec.treesitter({ a = "@assignment.outer", i = "@assignment.inner" }),
          m = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
          c = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }),
          C = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
          e = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line("$"),
              col = math.max(vim.fn.getline("$"):len(), 1),
            }
            return { from = from, to = to }
          end,
        },
      }
    end,
  },

  -- Better than mini.comment
  -- mini.comment does not have block comments (gb, gbc)
  -- mini.comment does not have gcA, gco, gcO
  -- missing 'gc' textobject from mini.comment for ops like 'dgc'
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      opts = {
        enable_autocmd = false,
      },
    },
    opts = {
      ignore = "^%s*$", -- Ignore blank lines
      pre_hook = function()
        require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      end,
    },
    keys = {
      { "<c-_>", function() require("Comment.api").toggle.linewise.current() end, mode = "i", desc = "Toggle comment" },
      { "gc", mode = { "n", "x" } },
      { "gb", mode = { "n", "x" } },
    },
  },

  -- ============================================= LSP =================================================
  -- {
  --   "neovim/nvim-lspconfig",
  --   event = "BufReadPost",
  --   cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
  --   dependencies = {
  --     "williamboman/mason.nvim",
  --     "williamboman/mason-lspconfig.nvim",
  --     "hrsh7th/cmp-nvim-lsp",
  --     "nvimtools/none-ls.nvim",
  --     "folke/neodev.nvim",
  --     "smjonas/inc-rename.nvim",
  --     "kevinhwang91/nvim-ufo",
  --     "kevinhwang91/promise-async",
  --   },
  --   config = function()
  --     local null_ls = require("null-ls")
  --     -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
  --     -- local lspconfig = require("lspconfig")

  --     require("neodev").setup()

  --     require("mason").setup({ ui = { border = "rounded" } })

  --     require("mason-lspconfig").setup({
  --       ensure_installed = { "lua_ls" },
  --       automatic_installation = true,
  --     })

  --     require("inc_rename").setup()

  --     local capabilities = vim.lsp.protocol.make_client_capabilities()
  --     capabilities.textDocument.foldingRange = {
  --       dynamicRegistration = false,
  --       lineFoldingOnly = true,
  --     }

  --     local language_servers = require("lspconfig").util.available_servers()

  --     for _, ls in ipairs(language_servers) do
  --       require("lspconfig")[ls].setup({ capabilities = capabilities })
  --     end

  --     -- fold options for ufo
  --     vim.opt.foldcolumn = "0"
  --     vim.opt.foldlevel = 99
  --     vim.opt.foldlevelstart = 99
  --     vim.opt.foldenable = true

  --     require("ufo").setup()

  --     null_ls.setup({
  --       sources = {
  --         null_ls.builtins.formatting.stylua,
  --         null_ls.builtins.formatting.black,
  --         null_ls.builtins.formatting.isort,
  --         --null_ls.builtins.diagnostics.eslint_d,
  --         null_ls.builtins.formatting.prettier,
  --       },
  --     })
  --   end,
  --   keys = {
  --     { "K", vim.lsp.buf.hover, desc = "LSP Hover" },
  --     { "gd", vim.lsp.buf.definition, desc = "LSP [g]o To [d]efinition" },
  --     -- { "<leader>rn", vim.lsp.buf.rename, desc = "LSP [r]e[n]ame" },
  --     {
  --       "<leader>rn",
  --       function()
  --         return ":IncRename " .. vim.fn.expand("<cword>")
  --       end,
  --       expr = true,
  --       desc = "LSP [r]e[n]ame",
  --     },
  --     { "<leader>ca", vim.lsp.buf.code_action, desc = "LSP [c]ode [a]ction", mode = { "n", "v" } },
  --     { "<leader>fm", vim.lsp.buf.format, desc = "LSP [f]or[m]at" },
  --   },
  -- },
  -- ============================================ COMPLETIONS ============================================
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     -- Snippet Engine & its associated nvim-cmp source
  --     "L3MON4D3/LuaSnip",
  --     "saadparwaiz1/cmp_luasnip",
  --     -- Adds LSP completion capabilities
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-path",
  --     -- Adds a number of user-friendly snippets
  --     "rafamadriz/friendly-snippets",
  --   },
  --   config = function()
  --     local cmp = require("cmp")
  --     require("luasnip.loaders.from_vscode").lazy_load()
  --     cmp.setup({
  --       snippet = {
  --         expand = function(args)
  --           -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
  --           require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
  --           -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
  --           -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
  --         end,
  --       },
  --       window = {
  --         completion = cmp.config.window.bordered(),
  --         documentation = cmp.config.window.bordered(),
  --       },
  --       mapping = cmp.mapping.preset.insert({
  --         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  --         ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --         ["<C-Space>"] = cmp.mapping.complete(),
  --         ["<C-e>"] = cmp.mapping.abort(),
  --         ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --       }),
  --       sources = cmp.config.sources({
  --         { name = "nvim_lsp" },
  --         -- { name = 'vsnip' }, -- For vsnip users.
  --         { name = "luasnip" }, -- For luasnip users.
  --         -- { name = 'ultisnips' }, -- For ultisnips users.
  --         -- { name = 'snippy' }, -- For snippy users.
  --       }, {
  --         { name = "buffer" },
  --       }),
  --     })
  --   end,
  -- },
  -- ========================================= DEBUGGING ========================================
  -- {
  --   "mfussenegger/nvim-dap",
  --   dependencies = {
  --     "rcarriga/nvim-dap-ui",
  --   },
  --   config = function()
  --     local dap = require("dap")
  --     local dapui = require("dapui")
  --     dap.listeners.before.attach.dapui_config = function()
  --       dapui.open()
  --     end
  --     dap.listeners.before.launch.dapui_config = function()
  --       dapui.open()
  --     end
  --     dap.listeners.before.event_terminated.dapui_config = function()
  --       dapui.close()
  --     end
  --     dap.listeners.before.event_exited.dapui_config = function()
  --       dapui.close()
  --     end

  --     vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint)
  --     vim.keymap.set("n", "<leader>dc", dap.continue)
  --   end,
  -- },
  -- ================================= WHICH KEY ====================================
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    -- init = function()
    --   vim.o.timeout=true
    --   vim.o.timeoutlen=300
    -- end,
  },
}

local map = require("config").map_keys

map("n", "<leader><space>", "<cmd>Telescope resume<cr>", { desc = "Resume" })
-- LSP
map("n", "<leader>o", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "LSP Document Symbols", buffer = 0 })
map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { desc = "LSP Implementations", buffer = 0 })
-- { "gd",         "<cmd>Telescope lsp_definitions<cr>",      desc = "LSP Definition",              buffer = 0 },
-- { "gr",         "<cmd>Telescope lsp_references<cr>",       desc = "LSP References",              buffer = 0 },
-- { "gt",         "<cmd>Telescope lsp_type_definitions<cr>", desc = "LSP Type Definitions",        buffer = 0 },
-- git
map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git Status" })
map("n", "<leader>gC", "<cmd>Telescope git_commits<cr>", { desc = "Git Commits" })
map("n", "<leader>gB", "<cmd>Telescope git_branches<cr>", { desc = "Git Branches" })
-- search
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<leader>,", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Search in Buffer" })
map("n", "<leader>?", "<cmd>Telescope live_grep<cr>", { desc = "Search in CWD" })
map("n", "<leader>:", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
map("n", "<leader>r", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })
-- { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Git-files" },
map("n", '<leader>"', "<cmd>Telesco,pe registers<cr>", { desc = "Registers" })
map("n", "<leader>sa", "<cmd>Telescope autocommands<cr>", { desc = "Auto Commands" })
map("n", "<leader>sc", "<cmd>Telescope commands<cr>", { desc = "Commands" })
map("n", "<leader>sn", "<cmd>Telescope notify<cr>", { desc = "Notifications" })
map("n", "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Document diagnostics" })
map("n", "<leader>sD", "<cmd>Telescope diagnostics<cr>", { desc = "Workspace diagnostics" })
map("n", "<leader>*", "<cmd>Telescope grep_string<cr>", { desc = "Search Word under cursor" })
map("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Help Pages" })
map("n", "<leader>sH", "<cmd>Telescope highlights<cr>", { desc = "Search Highlight Groups" })
map("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps" })
map("n", "<leader>sM", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
map("n", "<leader>sm", "<cmd>Telescope marks<cr>", { desc = "Jump to Mark" })
map("n", "<leader>so", "<cmd>Telescope vim_options<cr>", { desc = "Options" })
map("n", "<leader>uC", "<cmd>Telescope colorscheme<cr>", { desc = "Colorscheme with preview" })
map("n", "<leader>ft", "<cmd>Telescope filetypes<cr>", { desc = "Change FileType" })

local opts = {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = "   ",
    entry_prefix = "    ",
    multi_icon = "   ",
    dynamic_preview_title = true,
    hidden = true,
    sorting_strategy = "ascending",
    -- winblend = 20,
    layout_strategy = "flex",
    layout_config = {
      prompt_position = "top",
    },
    -- include hidden files in live_grep
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
    },
    mappings = {
      i = {
        ["<c-h>"] = false,
        ["<c-j>"] = false,
        ["<c-k>"] = false,
        ["<c-l>"] = false,
      },
      n = {
        ["<c-c>"] = "close",
      },
    },
  },
  pickers = {
    find_files = {
      -- include hidden files but not .git dir
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
    oldfiles = {
      theme = "dropdown",
    },
    grep_string = {
      -- include hidden files but not .git dir
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
    command_history = {
      theme = "dropdown",
    },
    buffers = {
      theme = "dropdown",
      -- layout_strategy = 'center',
      previewer = false,
      ignore_current_buffer = true,
      sort_mru = true,
      sort_lastused = true,
      layout_config = {
        anchor = "N",
      },
      mappings = {
        i = {
          ["<c-x>"] = "delete_buffer",
        },
        n = {
          x = "delete_buffer",
        },
      },
    },
    colorscheme = {
      enable_preview = true,
      layout_strategy = "vertical",
      layout_config = {
        anchor = "SE",
        width = 30,
        height = 20,
        preview_height = 1,
        prompt_position = "bottom",
      }
    },
    filetypes = {
      layout_config = {
        anchor = "SE",
        width = 30,
        height = 10,
        prompt_position = "bottom",
      },
    },
    diagnostics = {
      theme = "ivy",
    },
    symbols = {
      theme = "cursor",
      layout_config = { width = 50 },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  }
}

local telescope = require("telescope")

telescope.setup(opts)
if vim.fn.executable("make") == 1 then
  --telescope.load_extension("fzf")
end

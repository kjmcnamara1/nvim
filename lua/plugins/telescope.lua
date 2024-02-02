return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = "Telescope",
    version = false,
    opts = {
      prompt_prefix = "   ",
    },
    keys = {
      -- common
      {
        "<leader><space>",
        "<cmd>Telescope find_files<cr>",
        desc = "Find Files",
      },
      {
        "<leader>,",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true theme=dropdown<cr>",
        desc = "Buffers",
      },
      {
        "<leader>/",
        "<cmd>Telescope live_grep<cr>",
        desc = "Live Grep",
      },
      {
        "<leader>:",
        "<cmd>Telescope command_history<cr>",
        desc = "Command History",
      },
      {
        "<leader>r",
        "<cmd>Telescope oldfiles theme=dropdown<cr>",
        desc = "Find Recent",
      },
      -- { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Git-files" },
      -- git
      {
        "<leader>gc",
        "<cmd>Telescope git_commits<cr>",
        desc = "Git Commits",
      },
      {
        "<leader>gs",
        "<cmd>Telescope git_status<cr>",
        desc = "Git Status",
      },
      -- search
      {
        '<leader>"',
        "<cmd>Telescope registers<cr>",
        desc = "Registers",
      },
      {
        "<leader>sa",
        "<cmd>Telescope autocommands<cr>",
        desc = "Auto Commands",
      },
      {
        "<leader>sb",
        "<cmd>Telescope current_buffer_fuzzy_find<cr>",
        desc = "Buffer",
      },
      {
        "<leader>sc",
        "<cmd>Telescope commands<cr>",
        desc = "Commands",
      },
      {
        "<leader>sd",
        "<cmd>Telescope diagnostics bufnr=0<cr>",
        desc = "Document diagnostics",
      },
      {
        "<leader>sD",
        "<cmd>Telescope diagnostics<cr>",
        desc = "Workspace diagnostics",
      },
      {
        "<leader>*",
        "<cmd>Telescope grep_string<cr>",
        desc = "Grep Word under cursor",
      },
      {
        "<leader>h",
        "<cmd>Telescope help_tags<cr>",
        desc = "Help Pages",
      },
      {
        "<leader>sH",
        "<cmd>Telescope highlights<cr>",
        desc = "Search Highlight Groups",
      },
      {
        "<leader>sk",
        "<cmd>Telescope keymaps<cr>",
        desc = "Key Maps",
      },
      {
        "<leader>sM",
        "<cmd>Telescope man_pages<cr>",
        desc = "Man Pages",
      },
      {
        "<leader>sm",
        "<cmd>Telescope marks<cr>",
        desc = "Jump to Mark",
      },
      {
        "<leader>so",
        "<cmd>Telescope vim_options<cr>",
        desc = "Options",
      },
      {
        "<leader>sR",
        "<cmd>Telescope resume<cr>",
        desc = "Resume",
      },
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
    "stevearc/dressing.nvim",
    opts = {
      input = {
        insert_only = false,
      },
    },
  },
}

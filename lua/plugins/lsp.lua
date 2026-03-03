if profile() ~= "default" then
  return {}
end

-- Turn off inlay hints in insert mode
local hint_group = vim.api.nvim_create_augroup("InlayHintsSmartToggle", { clear = true })
local hints_were_enabled = false

vim.api.nvim_create_autocmd("InsertEnter", {
  group = hint_group,
  callback = function()
    hints_were_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
    -- dd(hints_were_enabled)
    if hints_were_enabled then
      vim.lsp.inlay_hint.enable(false, { bufnr = 0 })
    end
  end
})
vim.api.nvim_create_autocmd("InsertLeave", {
  group = hint_group,
  callback = function()
    -- dd(hints_were_enabled)
    if hints_were_enabled then
      vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
    end
  end
})


vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  -- jump = { float = true },
  signs = {
    text = { " ", " ", " ", "󰠠 " },
    numhl = {
      "DiagnosticSignError",
      "DiagnosticSignWarn",
      "DiagnosticSignInfo",
      "DiagnosticSignHint",
    },
  },
})


return {

  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonUpdate", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason", mode = { "n", "x" } },
    },
    opts = {},
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = "mason-org/mason.nvim",
    cmd = { "MasonToolsInstall", "MasonToolsInstallSync", "MasonToolsUpdate", "MasonToolsUpdateSync", "MasonToolsClean" },
    opts_extend = { "ensure_installed" },
    opts = {
      auto_update = true,
      run_on_start = true,
      ensure_installed = {
        -- Common / Web
        "prettierd",
        "cssls",
        "jsonls",
        "taplo",
        "marksman",
        "yamlls",
        "gh_actions_ls",

        -- Uncommon
        "hyprls",

        -- Neovim
        "lua_ls",
        "ts_query_ls",

        -- Shell
        "bashls",
        "shfmt",
        "fish_lsp",

        -- Python
        "basedpyright",
        "ty",
        "ruff",
        "debugpy",
        "jinja_lsp",

        -- Nix
        "nil_ls",
        "nixfmt",

        -- Rust
        "rust_analyzer",
        "codelldb",
      }
    },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = "mason-org/mason.nvim",
    lazy = true,
    opts = {
      automatic_enable = {
        exclude = {
          -- "rust_analyzer", -- Conflicts with rustaceanvim
          -- "basedpyright", -- still useful for highlighting
          -- "ty",
        },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>k",   function() vim.lsp.buf.hover({ border = "rounded" }) end, desc = "LSP: Hover", mode = { "n", "x" }, },
      { "<leader>cil", "<cmd>checkhealth vim.lsp<cr>",                           desc = "Info: LSP",  mode = { "n", "x" }, },
    }
  },

  {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    opts = {
      foldKeymaps = {
        scrollLeftOnCaret = true,
      }
    },
  },

  {
    "nvimtools/none-ls.nvim",
    dependencies = "williamboman/mason.nvim",
    cmd = { "NullLsInfo", "NullLsLog" },
    keys = {
      { "<leader>cin", "<cmd>NullLsInfo<cr>", desc = "Info: Null-Ls", mode = { "n", "x" } },
    },
    config = function(_, opts)
      local nls = require("null-ls")
      nls.setup({
        sources = {
          nls.builtins.hover.printenv,
          nls.builtins.diagnostics.fish,
        }
      })
    end,
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        -- show_source = {
        --   enabled = true,
        --   if_many = true,
        -- },
        multilines = {
          enabled = true,
        },
        use_icons_from_diagnostic = true,
      },
    },
  },

  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
    },
    event = "VeryLazy",
    keys = {
      { "g.", function() require("tiny-code-action").code_action() end, desc = "LSP: Code Action", mode = { "n", "x" }, },
    },
    opts = {
      backend = "delta",
      picker = {
        "snacks",
        opts = {
          layout = "code_action",
          focus = "list",
        },
      },
      -- backend = "difftastic",
      -- picker = {
      --   "buffer",
      --   opts = {
      --     hotkeys = true,
      --     hotkeys_mode = "text_based",
      --     auto_preview = true,
      --   }
      -- }
    },
  },

  {
    "saecki/live-rename.nvim",
    keys = {
      { "grn", function() require("live-rename").rename() end, desc = "LSP: Rename", mode = { "n", "x" } },
    },
    opts = { hl = { current = "IncSearch" } },
  },

  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      { "<leader>cic", "<cmd>ConformInfo<cr>",                     desc = "Info: Conform", mode = { "n", "x" } },
      { '<leader>cf',  function() require('conform').format() end, desc = "LSP: Format",   mode = { "n", "x" } },
    },
    opts = {
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      default_format_opts = {
        lsp_format = "prefer",
        async = true,
      },
      formatters = {
        shfmt = {
          append_args = { "-i", "2", "-bn", "-ci", "-sr", "-kp" },
        },
      },
      formatters_by_ft = {
        sh = { "shfmt" },
        zsh = { "shfmt" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        yaml = { "prettierd" },
        nix = { "nixfmt" },
        xonsh = { "ruff" },
        fish = { "fish_indent" },
        markdown = { "prettierd" },
        rust = { "rustfmt" },
      }
    },
    config = function(_, opts)
      require("conform").setup(opts)
      vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    init = function()
      -- Automatically clear the conform log on startup
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("ConformLogCleanup", { clear = true }),
        callback = function()
          local log_path = vim.fn.stdpath("state") .. "/conform.log"
          local f = io.open(log_path, "w")
          if f then
            f:write("")
            f:close()
          end
        end,
      })
    end
  },

}

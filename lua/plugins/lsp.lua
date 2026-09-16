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

-- Mason tools, grouped by the filetype that needs them. This is the single
-- source of truth: mason-tool-installer's `ensure_installed` is derived from
-- this table (for manual bulk install/update/clean), and the FileType
-- autocmd below installs only the tools for a given filetype the first time
-- it's opened.
local ft_tools = {
  json = { "jsonls", "prettierd" },
  jsonc = { "jsonls", "prettierd" },
  yaml = { "yamlls", "gh_actions_ls", "prettierd" },
  toml = { "taplo" },
  markdown = { "marksman", "prettierd" },
  css = { "cssls" },
  scss = { "cssls" },
  less = { "cssls" },
  hypr = { "hyprls" },
  lua = { "lua_ls" },
  query = { "ts_query_ls" },
  sh = { "bashls", "shfmt" },
  bash = { "bashls", "shfmt" },
  zsh = { "shfmt" },
  fish = { "fish_lsp" },
  python = { "basedpyright", "ty", "ruff", "debugpy", "jinja_lsp" },
  ruby = { "ruby_lsp", "rubocop", "rdbg" },
  nix = { "nil_ls", "nixfmt" },
  rust = { "rust_analyzer", "codelldb" },
}

-- Some names in ft_tools are lspconfig server names (e.g. "ruby_lsp",
-- "lua_ls") that differ from their actual Mason registry package name (e.g.
-- "ruby-lsp", "lua-language-server"). Resolve through mason-lspconfig's
-- mapping table, falling back to the raw name for tools that aren't LSP
-- servers (formatters, DAP adapters) where the two already match.
local function resolve_package_name(name)
  local ok_mlsp, mappings = pcall(require, "mason-lspconfig.mappings")
  if ok_mlsp then
    local ok_map, mason_map = pcall(mappings.get_mason_map)
    if ok_map and mason_map.lspconfig_to_package[name] then
      return mason_map.lspconfig_to_package[name]
    end
  end
  return name
end

local function mason_ensure_installed(names)
  local ok, registry = pcall(require, "mason-registry")
  if not ok then return end
  registry.refresh(function()
    for _, name in ipairs(names) do
      local ok_pkg, pkg = pcall(registry.get_package, resolve_package_name(name))
      if ok_pkg and not pkg:is_installed() then
        pkg:install()
      end
    end
  end)
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("LazyMasonToolInstall", { clear = true }),
  pattern = vim.tbl_keys(ft_tools),
  callback = function(args)
    mason_ensure_installed(ft_tools[args.match])
  end,
})


return {

  {
    "mason-org/mason.nvim",
    cond = profile() == "default",
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
    cond = profile() == "default",
    cmd = { "MasonToolsInstall", "MasonToolsInstallSync", "MasonToolsUpdate", "MasonToolsUpdateSync", "MasonToolsClean" },
    opts_extend = { "ensure_installed" },
    opts = {
      auto_update = true,
      -- Tools are installed lazily per-filetype (see the FileType autocmd
      -- above), not all at once on startup. This list is kept only so
      -- :MasonToolsInstall / :MasonToolsUpdate / :MasonToolsClean have a full
      -- set to work with when run manually.
      run_on_start = false,
      ensure_installed = (function()
        local seen, list = {}, {}
        for _, tools in pairs(ft_tools) do
          for _, name in ipairs(tools) do
            if not seen[name] then
              seen[name] = true
              table.insert(list, name)
            end
          end
        end
        return list
      end)(),
    },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = "mason-org/mason.nvim",
    cond = profile() == "default",
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
      "mason-org/mason-lspconfig.nvim",
    },
    cond = profile() == "default",
    lazy = false,
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>k",   function() vim.lsp.buf.hover({ border = "rounded" }) end, desc = "LSP: Hover", mode = { "n", "x" }, },
      { "<leader>cil", "<cmd>checkhealth vim.lsp<cr>",                           desc = "Info: LSP",  mode = { "n", "x" }, },
    }
  },

  {
    "chrisgrieser/nvim-origami",
    cond = profile() == "default",
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
    cond = profile() == "default",
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
    cond = profile() == "default",
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
    cond = profile() == "default",
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
    cond = profile() == "default",
    keys = {
      { "grn", function() require("live-rename").rename() end, desc = "LSP: Rename", mode = { "n", "x" } },
    },
    opts = { hl = { current = "IncSearch" } },
  },

  {
    "j-hui/fidget.nvim",
    cond = profile() == "default",
    event = "LspAttach",
    opts = {},
  },

  {
    "stevearc/conform.nvim",
    cond = profile() == "default",
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
        mojo = {
          command = "mojo",
          args = { "format", "-" },
          stdin = true,
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
        mojo = { "mojo" },
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

  {
    "linux-cultist/venv-selector.nvim",
    cond = profile() == "default",
    ft = "python",
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv", },
    },
    opts = { settings = { options = { notify_user_on_venv_activation = true } } },
  },

  {
    "folke/lazydev.nvim",
    cond = profile() == "default",
    ft = "lua",
    cmd = "LazyDev",
    keys = {
      { "<leader>cis", "<cmd>LazyDev lsp<cr>", desc = "Info: Attached LSP Config", mode = { "n", "x" } },
    },
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim",        words = { "Snacks" } },
      }
    },
  },

  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "toml" },
        group = vim.api.nvim_create_augroup("EmbedToml", {}),
        callback = function()
          require("otter").activate()
        end,
      })
    end,
  },

}

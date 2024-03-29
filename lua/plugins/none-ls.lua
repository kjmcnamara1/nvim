local map = require("config").map_keys

local null_ls = require("null-ls")
local diag = null_ls.builtins.diagnostics
local fmt = null_ls.builtins.formatting
local hover = null_ls.builtins.hover

-- require("mason-null-ls").setup({
--   ensure_installed = {
--     "prettierd",
--     "shfmt", -- instead of beauoysh
--   },
--   handlers = {},
-- })

-- TODO: need to add nvim-nu
null_ls.setup({
  sources = {
    -- fmt.prettierd.with({
    --   extra_filetypes = { "toml" },
    -- }),
    -- diag.shellcheck,
    -- ca.shellcheck,
    -- fmt.beautysh,
    diag.fish,
    fmt.fish_indent,
    fmt.shfmt.with({
      extra_filetypes = { "zsh" },
      extra_args = { "-i", "2", "-bn", "-ci", "-sr", "-kp" },
    }),
    hover.printenv,
  }
})

map("n", "<leader>cI", "<cmd>NullLsInfo<cr>", { desc = "Null Ls Info", buffer = 0 })

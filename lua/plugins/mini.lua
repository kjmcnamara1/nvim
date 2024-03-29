local map = require("config").map_keys
local augroup = require("config").augroup

-- Underline all other occurrences of word under cursor
require("mini.cursorword").setup()

-- Surroundings
vim.keymap.set("n", "s", "<nop>")
require("mini.surround").setup()

-- Highlight current indent level
vim.api.nvim_create_autocmd("FileType", {
  desc = "Automatically disable mini.indentscope for certain filetypes",
  group = augroup("disable_indentscope"),
  pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "trouble", "lazy", "mason", "notify", "toggleterm", "lazyterm" },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

require("mini.indentscope").setup({
  symbol = "│",
  draw = {
    animation = function() return 0 end,
  },
  options = {
    try_as_border = true,
  },
})

-- Additional text objects
local ai = require("mini.ai")
ai.setup({
  n_lines = 500,
  custom_textobjects = {
    -- o = ai.gen_spec.treesitter({
    --   a = { "@block.outer", "@conditional.outer", "@loop.outer" },
    --   i = { "@block.inner", "@conditional.inner", "@loop.inner" },
    -- }),
    ["="] = ai.gen_spec.treesitter({ a = "@assignment.outer", i = "@assignment.inner" }),
    m = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
    c = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }),
    C = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
    l = ai.gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }),
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
)
-- Column style buffer-based file browser
require("mini.files").setup({
  content = {
    filter = function(fs_entry)
      return fs_entry.name ~= ".git"
    end
  },
  windows = {
    preview = true,
  },
  mappings = {
    reveal_cwd = "_",
  },
})

map("n", "-", function() require("mini.files").open(vim.api.nvim_buf_get_name(0)) end,
  { desc = "Mini File Browser Current File" })
map("n", "_", function() require("mini.files").open(vim.fn.getcwd()) end, { desc = "Mini File Browser CWD" })

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesWindowOpen",
  callback = function(args)
    local win_id = args.data.win_id
    vim.api.nvim_win_set_config(win_id, { border = "rounded" })
  end,
})

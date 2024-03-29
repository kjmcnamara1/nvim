local map = require("config").map_keys
local augroup = require("config").augroup

require("neogit").setup({
  -- kind             = "replace",
  disable_hint     = true,
  graph_style      = "unicode",
  telescope_sorter = function()
    return require("telescope").extensions.fzf.native_fzf_sorter()
  end,
  signs            = {
    -- { CLOSED, OPENED }
    section = { "", "" },
    item = { "", "" },
    hunk = { "", "" },
  },
})

map("n", "<leader>gd", "<cmd>DiffviewOpen -- %<cr><cmd>DiffviewToggleFiles<cr>", { desc = "Open Git Diffview" })
map("n", "<leader>gD", "<cmd>DiffviewOpen<cr>", { desc = "Open Git Diffview" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "Open Git Current History" })
map("n", "<leader>gH", "<cmd>DiffviewFileHistory<cr>", { desc = "Open Git File History" })

map("n", "<leader>gg",
  function()
    local ng = require("neogit")
    if ng.status.status_buffer then
      ng.close()
    else
      ng.open()
    end
  end,
  { desc = "Toggle NeoGit Status" }
)
map("n", "<leader>gc",
  function()
    require("neogit").action("commit", "commit", {})()
  end,
  { desc = "Git Commit" }
)
-- BUG: Need to fix
map("n", "<leader>gp",
  function()
    require("neogit").action("pull", "from_upstream")()
  end,
  { desc = "Git Pull" }
)
map("n", "<leader>gP",
  function()
    require("neogit").action("push", "to_pushremote")()
  end,
  { desc = "Git Push" }
)

vim.api.nvim_create_autocmd("FileType", {
  desc = "Set position, size, and mode of git commit window",
  group = augroup("gitcommit"),
  pattern = "gitcommit,NeogitCommitMessage",
  callback = function()
    -- if vim.g.in_diffview then
    --   vim.cmd.wincmd("J")
    --   vim.api.nvim_win_set_height(0, math.min(20, math.floor(.5 * vim.o.lines)))
    -- else
    vim.cmd.wincmd("L")
    vim.api.nvim_win_set_width(0, math.min(66, math.floor(.5 * vim.o.columns)))
    -- end
    vim.cmd.startinsert()
  end
})

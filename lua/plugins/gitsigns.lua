local map = require("config").map_keys

map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle Git Blame" })
map("n", "<leader>gw", "<cmd>Gitsigns toggle_word_diff<cr>", { desc = "Toggle Git Word Diff" })
map("n", "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", { desc = "Git Stage Buffer" })
map("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", { desc = "Git Reset Buffer" })
-- { "<leader>gdi", "<cmd>Gitsigns diffthis<cr>",                  desc = "Git Diff Current File to Index", buffer = 0 },
-- { "<leader>gdh", "<cmd>Gitsigns diffthis ~<cr>",                desc = "Git Diff Current File to HEAD",  buffer = 0 },

-- Git Hunks
map("n", "<leader>hi", "<cmd>Gitsigns preview_hunk_inline<cr>", { desc = "Preview Git Hunk Inline" })
map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview Git Hunk" })
map("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage Git Hunk" })
map("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset Git Hunk" })
map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "Undo Stage Git Hunk" })

-- Movements
map("n", "]h", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next Git Hunk" })
map("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Previous Git Hunk" })

-- Text Object (need :<c-u> instead of <cmd> to select entire hunk)
map({ "o", "x" }, "ih", ":<c-u>Gitsigns select_hunk<cr>", { desc = "Inside Git Hunk" })
map({ "o", "x" }, "ah", ":<c-u>Gitsigns select_hunk<cr>", { desc = "Around Git Hunk" })

require("gitsigns").setup({
  preview_config = {
    border = "rounded",
  },
})

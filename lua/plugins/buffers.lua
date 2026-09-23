-- Like BufferLineCycleNext/Prev, but also steps into collapsed groups
-- (toggle_hidden_on_enter then expands them)
local function cycle(direction)
  local list = vim.tbl_filter(function(item)
    return item.focusable ~= false
  end, require("bufferline.state").__components)
  if #list == 0 then return end
  local current = vim.api.nvim_get_current_buf()
  for i, item in ipairs(list) do
    if item.id == current then
      local next_item = list[(i - 1 + direction) % #list + 1]
      vim.api.nvim_set_current_buf(next_item.id)
      return
    end
  end
end

return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "nvim-mini/mini.icons",
    "folke/snacks.nvim",
    -- { "backdround/tabscope.nvim", config = true },
  },
  cond = profile() == "default",
  event = "VeryLazy",
  keys = {
    { "<leader>'", "<c-^>",                        desc = "Buffer: Alternate" },
    { "<c-n>",     "<cmd>enew<cr>",                desc = "Buffer: New" },
    { "<a-p>",     "<cmd>BufferLineTogglePin<cr>", desc = "Buffer: Pin" },
    { "<a-s-l>",   "<cmd>BufferLineMoveNext<cr>",  desc = "Buffer: Move Right" },
    { "<a-s-h>",   "<cmd>BufferLineMovePrev<cr>",  desc = "Buffer: Move Left" },
    { "<a-l>",     function() cycle(1) end,        desc = "Buffer: Next" },
    { "<a-h>",     function() cycle(-1) end,       desc = "Buffer: Prev" },
  },
  opts = function()
    return {
      options = {
        tab_size = 15,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        close_command = Snacks.bufdelete.delete,
        right_mouse_command = Snacks.bufdelete.delete,
        groups = {
          options = {
            toggle_hidden_on_enter = true,
          },
          items = {
            {
              name = "Docs",
              highlight = { underline = true },
              auto_close = true,
              priority = 2,
              matcher = function(buf)
                return buf.name:match('%.md')
                    -- or buf.name:match('%.txt')
                    or buf.name == "LICENSE"
                    or buf.name == "mkdocs.yml"
              end,
              separator = {
                style = require('bufferline.groups').separator.pill
              },
            },
            {
              name = "Tests",
              highlight = { sp = vim.api.nvim_get_hl(0, { name = "Error" }).fg },
              auto_close = true,
              priority = 3,
              icon = " ",
              matcher = function(buf)
                return buf.name:match('test_')
              end,
            },
          }
        }
      }
    }
  end,
}

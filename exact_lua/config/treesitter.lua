vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  -- "https://github.com/aaronik/treewalker.nvim",
})

wk.add({
  { "<leader>ui", "<cmd>Inspect<cr>",     desc = "Inspect: Position" },
  { "<leader>ut", "<cmd>InspectTree<cr>", desc = "Inspect: Tree" },
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Auto configure treesitter for each filetype",
  group = vim.api.nvim_create_augroup("AutoTreesitter", { clear = true }),
  callback = function(ev)
    local bufnr = ev.buf
    local ft = ev.match
    local ts = require("nvim-treesitter")

    if not vim.list_contains(ts.get_available(), ft) then
      return
    end

    ts.install(ft):await(function()
      if not vim.api.nvim_buf_is_loaded(bufnr) then
        return
      end
      if vim.list_contains(ts.get_installed(), ft) then
        -- if `highlight`
        vim.treesitter.start(bufnr)
        -- if `fold`
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        -- if `indent`
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end)
  end
})

require("nvim-treesitter-textobjects").setup({
  move = {
    set_jumps = true,
  },
})

-- require("treewalker").setup({
--   select = true,
-- })
-- wk.add({
--   mode = { "n", "x" },
--   { "<a-p>", "<cmd>Treewalker Up<cr>",    desc = "TreeWalker: Up" },
--   { "<a-n>", "<cmd>Treewalker Down<cr>",  desc = "TreeWalker: Down" },
--   { "<a-o>", "<cmd>Treewalker Left<cr>",  desc = "TreeWalker: Left" },
--   { "<a-i>", "<cmd>Treewalker Right<cr>", desc = "TreeWalker: Right" },
-- })

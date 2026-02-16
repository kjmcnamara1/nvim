-- TODO: treesitter injections for chezmoitmpl

pack_add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/HiPhish/rainbow-delimiters.nvim",
  -- "https://github.com/aaronik/treewalker.nvim",
})

wk.add({
  { "<leader>ui", "<cmd>Inspect<cr>",     desc = "Treesitter: Inspect" },
  { "<leader>ut", "<cmd>InspectTree<cr>", desc = "Treesitter: Inspect Tree" },
  { "<leader>uT", "<cmd>EditQuery<cr>",   desc = "Treesitter: Query" },
})

require("nvim-treesitter").install({ "regex" })

vim.api.nvim_create_autocmd("FileType", {
  desc = "Auto configure treesitter for each filetype",
  group = vim.api.nvim_create_augroup("AutoTreesitter", { clear = true }),
  callback = function(ev)
    local bufnr = ev.buf
    local lang = vim.treesitter.language.get_lang(ev.match) or ev.match
    local ts = require("nvim-treesitter")

    if not vim.list_contains(ts.get_available(), lang) then
      return
    end

    ts.install(lang):await(function()
      if not vim.api.nvim_buf_is_loaded(bufnr) then
        return
      end
      if vim.list_contains(ts.get_installed(), lang) then
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

-- vim.api.nvim_create_autocmd("FileType", {
--   desc     = "Add @comment.deprecated to all TS highlights",
--   group    = vim.api.nvim_create_augroup("GlobalTSQueries", { clear = true }),
--   callback = function(ev)
--     local lang = vim.treesitter.language.get_lang(ev.match) or ev.match
--     if vim.list_contains({ "markdown", "markdown_inline", "html" }, lang) then return end
--     local has_parser = vim.treesitter.language.add(lang)
--     if not has_parser then return end

--     local cs = vim.bo.commentstring:match([[^(%S+)%s*%%s]])
--     if not cs then return end
--     local query_match = "^" .. string.rep(cs, 2)

--     local all_lines = {}
--     local paths = vim.treesitter.query.get_files(lang, "highlights")
--     for _, path in ipairs(paths) do
--       local ok, lines = pcall(vim.fn.readfile, path)
--       if not ok then return end
--       vim.list_extend(all_lines, lines)
--       -- Add an empty string to act as a newline between files
--       table.insert(all_lines, "")
--     end

--     local current_query = table.concat(all_lines, "\n")

--     local custom_query = string.format([[
--       ((comment) @comment.deprecated
--       (#match? @comment.deprecated %q)
--       (#set! priority 150))
--       ]], query_match)

--     local new_query = current_query .. custom_query
--     vim.treesitter.query.set(lang, "highlights", new_query)
--   end
-- })

require("nvim-treesitter-textobjects").setup({
  move = {
    set_jumps = true,
  },
})

require("rainbow-delimiters.setup").setup({
  highlight = {
    "SnacksIndentScope1",
    "SnacksIndentScope2",
    "SnacksIndentScope3",
    "SnacksIndentScope4",
    -- "SnacksIndentScope5", -- green easy to confuse with strings
    "SnacksIndentScope6",
    "SnacksIndentScope7",
    "SnacksIndentScope8",
  }
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

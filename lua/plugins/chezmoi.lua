-- TODO: chezmoi-treesitter.nvim
-- vim.filetype.add to detect compound ft from chezmoi target file
-- (e.g. toml.chezmoitmpl)
-- create FileType autoccommand:
-- gotmpl as primary treesitter parser
-- add treesitter injection for primary lang (e.g. toml) with:
-- local query = string.format([[
-- ((text) @injection.content
-- (#set! injection.language %q)
-- (#set! injection.combined))
-- ]], lang)
-- vim.treesitter.query.set("gotmpl","injections",currt_query .. query)


return {
  "xvzc/chezmoi.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  cond = profile() == "default",
  opts = { edit = { watch = true } },
  init = function()
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      desc = "Auto-watch chezmoi files",
      group = vim.api.nvim_create_augroup("chezmoi", { clear = true }),
      pattern = vim.fn.fnamemodify('~/.local/share/chezmoi/*', ":p"):gsub('\\', '/'),
      callback = function(event)
        local filename = vim.fs.basename(event.file)
        if vim.startswith(filename, 'run_') then -- exclude chezmoi run scripts
          return
        end
        vim.schedule(require("chezmoi.commands.__edit").watch)
        vim.notify('Chezmoi watching ' .. filename, vim.log.levels.INFO)
      end,
    })
  end
}

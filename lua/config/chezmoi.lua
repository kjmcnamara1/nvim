if profile() ~= "default" then
  return
end

pack_add({ "https://github.com/xvzc/chezmoi.nvim" })

require("chezmoi").setup({ edit = { watch = true } })
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

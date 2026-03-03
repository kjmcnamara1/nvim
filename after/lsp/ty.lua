vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Only use ty (lsp) for foldingRangeProvider",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "ty" then return end
    local preserve = {
      "foldingRangeProvider",
      -- "positionEncoding",
      "textDocumentSync",
    }

    for k, _ in pairs(client.server_capabilities) do
      if not vim.tbl_contains(preserve, k) then
        client.server_capabilities[k] = nil
      end
    end
  end,
})

return {
  settings = {
    ty = {
      diagnosticMode = "workspace",
      -- disableLanguageServices = true,
    },
  },
}

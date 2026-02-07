if profile() ~= "default" then
  return
end

pack_add({
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/yetone/avante.nvim",
})

require("avante").setup({
  provider = "gemini",
  input = { provider = "snacks", },
  providers = {
    gemini = {
      -- list models with:
      -- curl -s "https://generativelanguage.googleapis.com/v1beta/models?key=$GEMINI_API_KEY" | jq .models[].name
      model = "gemini-3-flash-preview",
      endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
    }
  }
})

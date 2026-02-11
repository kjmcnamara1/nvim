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
      -- model = "gemini-3-flash-preview",
      -- model = "gemini-flash-latest",
      model = "gemini-2.5-flash",
      endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
    },
    -- grok = {
    --   __inherited_from = "openai",
    --   model = "grok-beta",
    --   endpoint = "https://api.x.ai/v1",
    --   api_key_name = "XAI_API_KEY",
    -- },
  }
})

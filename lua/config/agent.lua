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
      model = "gemini-flash-latest",
      -- model = "gemini-2.5-flash",
      -- model = "gemini-1.5-flash",
      -- endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
    },
    -- grok = {
    --   __inherited_from = "openai",
    --   -- model = "grok-beta",
    --   model = "llama-3.3-70b-versatile",
    --   endpoint = "https://api.x.ai/v1",
    --   api_key_name = "XAI_API_KEY",
    -- },
    -- ollama = {
    --   __inherited_from = "openai",
    --   endpoint = "http://127.0.0.1:11434/v1",
    --   model = "qwen2.5-coder:7b",
    --   api_key_name = "OLLAMA_API_KEY",
    -- },
  }
})

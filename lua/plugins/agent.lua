return {

  {
    "yetone/avante.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    enabled = false,
    cond = profile() == "default",
    build = ":AvanteBuild",
    event = "VeryLazy",
    version = false,
    opts = {
      provider = "gemini",
      input = { provider = "snacks", },
      providers = {
        gemini = {
          -- list models with:
          -- curl -s "https://generativelanguage.googleapis.com/v1beta/models?key=$GEMINI_API_KEY" | jq .models[].name
          -- model = "antigravity",
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
    },
  },

  {
    "folke/sidekick.nvim",
    cond = profile() == "default",
    opts = {
      -- add any options here
      cli = {
        tools = {
          antigravity = {
            cmd = { "agy" },
          },
        },
        -- mux = {
        --   backend = "zellij",
        --   enabled = true,
        -- },
        nes = { enabled = false },
      },
    },
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<c-.>",
        function() require("sidekick.cli").focus() end,
        desc = "Sidekick Focus",
        mode = { "n", "t", "i", "x" },
      },
      {
        "<leader>aa",
        function() require("sidekick.cli").toggle() end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>as",
        function() require("sidekick.cli").select() end,
        -- Or to select only installed tools:
        -- require("sidekick.cli").select({ filter = { installed = true } })
        desc = "Select CLI",
      },
      {
        "<leader>ad",
        function() require("sidekick.cli").close() end,
        desc = "Detach a CLI Session",
      },
      {
        "<leader>at",
        function() require("sidekick.cli").send({ msg = "{this}" }) end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>af",
        function() require("sidekick.cli").send({ msg = "{file}" }) end,
        desc = "Send File",
      },
      {
        "<leader>av",
        function() require("sidekick.cli").send({ msg = "{selection}" }) end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      {
        "<leader>ap",
        function() require("sidekick.cli").prompt() end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
      -- Example of a keybinding to open Claude directly
      -- {
      --   "<leader>ac",
      --   function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
      --   desc = "Sidekick Toggle Claude",
      -- },
    },
  },

}

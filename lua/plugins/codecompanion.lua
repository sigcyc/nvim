return {
    "olimorris/codecompanion.nvim",
    opts = {
      adapters = {
        acp = {
          codex = function()
            return require("codecompanion.adapters").extend("codex", {
              defaults = { auth_method = "openai-api-key" },
              env = { OPENAI_API_KEY = os.getenv("OPENAI_API_KEY") },
            })
          end,
          gemini_cli = function()
            return require("codecompanion.adapters").extend("gemini_cli", {
              defaults = { auth_method = "gemini-api-key"},
              env = { GEMINI_API_KEY = os.getenv("GEMINI_API_KEY") },
            })
          end,
        },
      },
      strategies = {
        chat = {
          adapter = "codex", -- ensures :CodeCompanionChat uses Codex ACP
        },
      },
      display = {
        chat = {
          window = {
            layout = "vertical", -- keep a vsplit
            position = "right",  -- always open on the right
            full_height = true,
          },
        },
      },
    },
  }


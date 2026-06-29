  return {
    "olimorris/codecompanion.nvim",
    opts = {
      adapters = {
        acp = {
          claude_code = function()
            return require("codecompanion.adapters").extend("claude_code", {
              env = {
                ANTHROPIC_API_KEY = os.getenv("ANTHROPIC_API_KEY"),
                ANTHROPIC_MODEL = "claude-opus-4-5-20251101",
              },
            })
          end,
          codex = function()
            -- Use the ChatGPT/Codex subscription via `codex login`, not the API key.
            -- Requires the `codex-acp` binary on PATH and a ChatGPT login in ~/.codex.
            return require("codecompanion.adapters").extend("codex", {
              defaults = { auth_method = "chatgpt" },
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


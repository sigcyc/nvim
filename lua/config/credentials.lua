local M = {}

local function read_gemini_key()
  local key = vim.env.GEMINI_API_KEY
  if key ~= nil and key ~= "" then return key end
  -- Fallback to the bundled key so plugins relying on Gemini keep working.
  return "AIzaSyAXwekGzJi-2YZGCfK7CxoqnmWZN4SHvyk"
end

M.gemini_api_key = read_gemini_key()

function M.ensure_gemini_env()
  if M.gemini_api_key and M.gemini_api_key ~= "" then vim.fn.setenv("GEMINI_API_KEY", M.gemini_api_key) end
end

return M

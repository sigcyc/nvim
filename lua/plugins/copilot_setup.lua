return {
  {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-l>",
          next = "<C-n>",
          prev = "<C-p>",
          dismiss = "<C-e>"
        },
      },
      panel = {
        enabled = true,
        keymap = {
          open = "<C-o>",
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<C-a>",
          refresh = "gr",
          close = "<C-c>",
        },
      },
    })
  end,
}
}

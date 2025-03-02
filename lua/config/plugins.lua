require("gruvbox").setup()
vim.cmd([[colorscheme gruvbox]])

local function map_leader(shortcut, func)
  vim.keymap.set("n", "<Leader>" .. shortcut, func)
end

require("neo-tree").setup{
  filesystem = {
    window = {
      mappings = {
        ["r"] = "refresh",
        ["R"] = "rename",
        ["o"] = "open",
        ["i"] = "toggle_hidden",
        ["u"] = "navigate_up"
      }
    }
  }
}
map_leader("n", "<cmd>Neotree toggle<CR>")

require('hop').setup()
map_leader("w", "<cmd>HopWordAC<CR>")
map_leader("W", "<cmd>HopLineAC<CR>")
map_leader("b", "<cmd>HopWordBC<CR>")
map_leader("B", "<cmd>HopLineBC<CR>")

--- fugitive
map_leader("gs", "<cmd>Git<CR>")
map_leader("dv", "<cmd>Gvdiffsplit<CR>")
map_leader("dq", ":<C-U>call fugitive#DiffClose()<CR>")
map_leader("gp", "<cmd>Git push origin<CR>")
map_leader("gl", "<cmd>Git pull<CR>")
map_leader("gg", "<cmd>Git log --all --decorate --oneline --graph<CR>")


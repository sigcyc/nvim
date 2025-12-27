require("gruvbox").setup()
vim.cmd([[colorscheme gruvbox]])

local function map_leader(mode, shortcut, func)
  vim.keymap.set(mode, "<Leader>" .. shortcut, func)
end

require("neo-tree").setup{
  filesystem = {
    window = {
      mappings = {
        ["/"] = "none",
        ["r"] = "refresh",
        ["R"] = "rename",
        ["o"] = "open",
        ["i"] = "toggle_hidden",
        ["u"] = "navigate_up",
        ["c"] = function(state)
          local node = state.tree:get_node()
          vim.cmd("let @+=\""..node.path.."\"")
        end,
      }
    }
  }
}
map_leader("n", "n", "<cmd>Neotree toggle<CR>")

require('hop').setup()
map_leader({"n", "v"}, "w", "<cmd>HopWordAC<CR>")
map_leader({"n", "v"}, "W", "<cmd>HopLineAC<CR>")
map_leader({"n", "v"}, "b", "<cmd>HopWordBC<CR>")
map_leader({"n", "v"}, "B", "<cmd>HopLineBC<CR>")

--- fugitive
map_leader("n", "gs", "<cmd>Git<CR>")
map_leader("n", "dv", "<cmd>Gvdiffsplit<CR>")
map_leader("n", "dq", ":<C-U>call fugitive#DiffClose()<CR>")
map_leader("n", "gp", "<cmd>Git push origin<CR>")
map_leader("n", "gl", "<cmd>Git pull<CR>")
map_leader("n", "gg", "<cmd>Git log --all --decorate --oneline --graph<CR>")

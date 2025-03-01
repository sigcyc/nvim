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

--- *fzf-lua*
local fzf = require('fzf-lua')
--- load workspaces into a table
local function load_file(type)
  out = {}
  local filename = vim.fn.stdpath('config') .. '/lua/config/' .. type .. '.json'
  local file = io.open(filename, 'r')
  if file then
    local contents = file:read("*a")
    local data = vim.json.decode(contents)
    for key, value in pairs(data) do
      table.insert(out, key .. "|" .. value)
    end
    io.close(file)
  end
  return out
end
local workspaces = load_file("workspaces")
local files = load_file("files")
-- Define a function that uses fzf-lua to let you pick a directory
local function pick_and_cd()
  fzf.fzf_exec(workspaces, {
    prompt = 'Select workspaces> ',
    actions = {
      -- The default action (Enter) will take the selected item...
      ['default'] = function(selected)
        -- selected is a list; grab the first (and only) item.
        local chosen_path = selected[1]:match('%|(.*)')
        if chosen_path then
          -- Change Neovim's working directory.
          vim.cmd('tcd ' .. chosen_path)
          vim.cmd('Neotree')
        end
      end,
    },
  })
end
vim.api.nvim_create_user_command('FzfWorkspaces', pick_and_cd, {})
local function pick_and_open()
  fzf.fzf_exec(files, {
    prompt = 'Select files> ',
    actions = {
      ['default'] = function(selected)
        local chosen_path = selected[1]:match('%|(.*)')
        if chosen_path then
          vim.cmd('edit ' .. chosen_path)
        end
      end,
    },
  })
end
vim.api.nvim_create_user_command('FzfFiles', pick_and_open, {})

-- comment

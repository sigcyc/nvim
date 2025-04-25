return {
  {
    "ibhagwan/fzf-lua",
    config = function()
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
      vim.keymap.set('n', '<Leader>gb', '<cmd>FzfLua git_bcommits<CR>')
    end
  }
}

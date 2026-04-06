return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local function get_working_directory()
        return vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
      end

      local function get_filename()
         if vim.opt.buftype:get() == 'terminal' then
            return vim.fn.fnamemodify(vim.fn.expand('%'), ':p:h:h:h:t') .. ':' .. vim.fn.fnamemodify(vim.fn.expand('%'), ':p:t')
         else
            return vim.fn.fnamemodify(vim.fn.expand('%'), ':p:t')
         end
      end
      require'lualine'.setup {
        options = {
          icons_enabled = false,
          theme = 'gruvbox',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {},
          always_divide_middle = false,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {{'diagnostics', sources={'nvim_lsp', 'coc'}}},
          lualine_c = {{'filename', path = 3}},
          lualine_x = {},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {get_filename},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {
          lualine_a = {
            {
              'tabs',
              mode = 1,
              max_length = vim.o.columns,
              section_separators = { left = '', right = '' },
              component_separators = { left = '|', right = '|' },
              fmt = function(_, context)
                return vim.fn.fnamemodify(vim.fn.getcwd(-1, context.tabnr), ':t')
              end,
            }
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
        extensions = {}
      }

    end
  }
}

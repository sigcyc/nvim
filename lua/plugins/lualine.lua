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
          always_divide_middle = true,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {{'diagnostics', sources={'nvim_lsp', 'coc'}}},
          lualine_c = {get_filename},
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
          lualine_a = {get_working_directory},
          lualine_b = {'filename'},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {'tabs'}
        },
        extensions = {}
      }

    end
  }
}

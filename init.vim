call plug#begin(stdpath('data') . '/plugged')
Plug 'morhetz/gruvbox'
"" neovim plugin 
Plug 'phaazon/hop.nvim'
Plug 'preservim/nerdcommenter'
Plug 'preservim/tagbar'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons' " optional, for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.x' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim'
call plug#end()

set rtp+=/Users/yichenchen/workspace/coc-lists

set tabstop=2
set winbar=%f
set shiftwidth=2
set expandtab
set smarttab
set guifont=MesloLGS\ Nerd\ Font:h16
set splitbelow
set ignorecase
set number relativenumber
let mapleader=","


"--- shortcuts ---
" movement
noremap <D-k> <C-w>k
noremap <D-l> <C-w>l
noremap <D-j> <C-w>j
noremap <D-h> <C-w>h
noremap <D-f> <C-d>
noremap <D-d> <C-u>
tnoremap <D-k> <C-\><C-N><C-w>k
tnoremap <D-l> <C-\><C-N><C-w>l
tnoremap <D-j> <C-\><C-N><C-w>j
tnoremap <D-h> <C-\><C-N><C-w>h
tnoremap <D-f> <C-\><C-N><C-d>
tnoremap <D-d> <C-\><C-N><C-u>
" window manipulation
noremap <D-w> :hid<CR>
noremap <D-q> :q<CR>
noremap <D-v> :vsplit<CR>
noremap <D-i> :split<CR>
noremap <D-t> :tabnew<CR>
noremap <D-x> <C-w>x
noremap <D-H> <C-w>H
noremap <D-J> <C-w>J
noremap <D-K> <C-w>K
noremap <D-L> <C-w>L
noremap <D--> <C-w>_
noremap <D-=> <C-w>=
noremap <D-\> <C-w><Bar>
noremap <D-.> 2<C-w>>
noremap <D-,> 2<C-w><
noremap <D-Left> gT 
noremap <D-Right> gt

tnoremap <D-w> <C-\><C-N>:hid<CR>
tnoremap <D-q> <C-\><C-N>:q<CR>
tnoremap <D-v> <C-\><C-N>:vsplit<CR>i
tnoremap <D-i> <C-\><C-N>:split<CR>i
tnoremap <D-t> <C-\><C-N>:tabnew<CR>i
tnoremap <D-x> <C-\><C-N><C-w>xi
tnoremap <D-H> <C-\><C-N><C-w>Hi
tnoremap <D-J> <C-\><C-N><C-w>Ji
tnoremap <D-K> <C-\><C-N><C-w>Ki
tnoremap <D-L> <C-\><C-N><C-w>Li
tnoremap <D--> <C-\><C-N><C-w>_i
tnoremap <D-=> <C-\><C-N><C-w>=i
tnoremap <D-\> <C-\><C-N><C-w><Bar>i
tnoremap <D-.> <C-\><C-N>2<C-w>>i
tnoremap <D-,> <C-\><C-N>2<C-w><i
tnoremap <D-Left> <C-\><C-N>gT 
tnoremap <D-Right> <C-\><C-N>gt

" terminal
noremap <D-e> :sp <Bar> term<CR>i
noremap <D-n> i
tnoremap <D-n> <C-\><C-N>
autocmd BufEnter * if &buftype ==# 'terminal' |:startinsert| endif 
tnoremap <D-e> <C-\><C-N>:sp <Bar> term<CR>i
tnoremap <D-F> <C-\><C-N>:lua change_terminal_name('


"run a block of code
nmap <D-r> yap<C-w>jpi<CR><D-k>}j
"run class and function. need ac af for function setup
nmap <D-u> mz"+yaf<C-w>ji%paste<CR><D-k>'z
nmap <D-c> mz"+yac<C-w>ji%paste<CR><D-k>'z

" clipboard path
noremap <Leader>cw :let t:wd = getcwd()<CR>
autocmd TabEnter * if exists("t:wd") | exe "cd" t:wd | endif

tmap <D-r> <C-\><C-N>pi 
tmap <D-'> <C-\><C-N>"+pi
nmap <Leader>cp cd:exe "!cp -r" '<C-r>+' getcwd()<CR>

" editting
nnoremap <Leader>s :.,$s/

"--- plugins ---
" hop
lua require('plugins/hop')
noremap <Leader>w :HopWordAC<CR>
noremap <leader>W :HopLineAC<CR>
noremap <Leader>b :HopWordBC<CR>
noremap <leader>B :HopLineBC<CR>
" nerdtree
noremap <Leader>n :Neotree toggle<CR>
" tagbar
nnoremap <silent><nowait> <D-g>  :call ToggleOutline()<CR>
function! ToggleOutline() abort
 let winid = coc#window#find('cocViewId', 'OUTLINE')
 if winid == -1
   call CocActionAsync('showOutline', 1)
 else
   call coc#window#close(winid)
 endif
endfunction
" telescope
noremap <D-s> :Telescope grep_string<CR>
noremap <D-S> :Telescope find_files<CR>
noremap <D-o> :Telescope buffers<CR>
noremap <D-b> :Telescope current_buffer_fuzzy_find<CR>
noremap <D-a> :Telescope tags<CR>
noremap <Leader>gh :Telescope git_bcommits<CR>
noremap <Leader>gc :Telescope git_commits<CR>
noremap <Leader>gf :Telescope git_files<CR>

tnoremap <D-s> <C-\><C-N>:Ag<CR>
tnoremap <D-S> <C-\><C-N>:Telescope find_files<CR>
tnoremap <D-o> <C-\><C-N>:Buffers<CR>
tnoremap <D-b> <C-\><C-N>:BLines<CR>
tnoremap <D-B> <C-\><C-N>:Lines<CR>
tnoremap <D-a> <C-\><C-N>:Tags<CR>
"git
noremap <Leader>gs :Git<CR>
nnoremap <Leader>gd :Gvdiffsplit @~1:%
nnoremap <Leader>gp :Git push origin<CR>
nnoremap <Leader>gl :Git pull<CR>
nnoremap <Leader>gg :Git log --all --decorate --oneline --graph<CR>
noremap <Leader>dq :<C-U>call fugitive#DiffClose()<CR>
noremap <Leader>dv :Gvdiffsplit<CR>

lua require('plugins/nvim-treesitter')
"lua require('plugins/lualine')

" coc nvim
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"


" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" CocList
nmap <D-m> :CocList workspaces<CR>
nmap <D-M> :lua add_workspace('

lua << EOF
function change_terminal_name(name)
  vim.api.nvim_command('file '..vim.fn.fnamemodify(vim.fn.bufname('%'), ':p:h').. '/' .. name)
end

local function get_working_directory()
  if vim.t.wd == nil then
    return ''
  else
    return vim.fn.fnamemodify(vim.t.wd , ':p:h:t')
  end
end

require('plenary.reload').reload_module('neo-tree', true)
-- nvim-tree.lua setup
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
        { key = "s", action = "vsplit" },
        { key = "cd", action = "cd"},
        { key = "C-x", action= "system_open" },
        { key = "I", action = "toggle_dotfiles"},
        { key = "H", action = "toggle_git_ignored"},
      },
    },
  },
  actions = {
    change_dir = {
      enable = false,
      global = true
    } 
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
-- neo-tree setup
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
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

-- indent_blankline setup
require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}


function add_workspace(name)
  local workspace_filename = '/Users/yichenchen/workspace/coc-lists/workspaces.json'
  local file = io.open(workspace_filename, 'r')
  if file then
    local contents = file:read("*a")
    content_json = vim.json.decode(contents)
    content_json[name] = vim.fn.getcwd()  
    io.close(file)
    local tkeys = {}
    for k in pairs(content_json) do table.insert(tkeys, k) end
    table.sort(tkeys)
    local file = io.open(workspace_filename, 'w')
    file:write('{\n')
    for idx, k in ipairs(tkeys) do
      if (idx ~= table.getn(tkeys)) then
        file:write("\"", k, "\": \"", content_json[k], "\", \n")
      else
        file:write("\"", k, "\": \"", content_json[k], "\"\n")
      end
    end
    file:write('}')
    io.close(file)
  end
end

require("telescope").setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<esc>"] = require('telescope.actions').close,
        ["<D-j>"] = require('telescope.actions').move_selection_next,
        ["<D-k>"] = require('telescope.actions').move_selection_previous,
      }
    }
  }
}
require("telescope").load_extension("fzf")
EOF

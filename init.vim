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
Plug 'nvim-neo-tree/neo-tree.nvim'
call plug#end()

set tabstop=3
set shiftwidth=3
set expandtab
set smarttab
set guifont=Monaco:h14
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

" editting
nnoremap <Leader>s :.,$s/

"--- plugins ---
" hop
lua require('plugins/hop')
noremap <Leader>w :HopWordAC<CR>
noremap <Leader>b :HopWordBC<CR>
" nerdtree
noremap <Leader>n :Neotree toggle<CR>
" tagbar
noremap <D-g> :Tagbar<CR>
" fzf
noremap <D-s> :Ag<CR>
noremap <D-S> :FZF<CR>
noremap <D-o> :Buffers<CR>
noremap <D-b> :BLines<CR>
noremap <D-B> :Lines<CR>
noremap <D-a> :Tags<CR>

tnoremap <D-s> <C-\><C-N>:Ag<CR>
tnoremap <D-S> <C-\><C-N>:FZF<CR>
tnoremap <D-o> <C-\><C-N>:Buffers<CR>
tnoremap <D-b> <C-\><C-N>:BLines<CR>
tnoremap <D-B> <C-\><C-N>:Lines<CR>
tnoremap <D-a> <C-\><C-N>:Tags<CR>
"fugitive
noremap <Leader>gs :Git<CR>
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
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
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

EOF

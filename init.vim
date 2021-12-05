call plug#begin(stdpath('data') . '/plugged')
Plug 'morhetz/gruvbox'
"" neovim plugin 
Plug 'phaazon/hop.nvim'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'preservim/tagbar'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
call plug#end()

set guifont=Monaco:h14
set splitbelow
set smartcase
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

tnoremap <D-w> <C-\><C-N>:hid<CR>
tnoremap <D-q> <C-\><C-N>:q<CR>
tnoremap <D-v> <C-\><C-N>:vsplit<CR>
tnoremap <D-i> <C-\><C-N>:split<CR>
tnoremap <D-t> <C-\><C-N>:tabnew<CR>
tnoremap <D-x> <C-\><C-N><C-w>x
tnoremap <D-H> <C-\><C-N><C-w>H
tnoremap <D-J> <C-\><C-N><C-w>J
tnoremap <D-K> <C-\><C-N><C-w>K
tnoremap <D-L> <C-\><C-N><C-w>L
tnoremap <D--> <C-\><C-N><C-w>_
tnoremap <D-=> <C-\><C-N><C-w>=
tnoremap <D-\> <C-\><C-N><C-w><Bar>
tnoremap <D-.> <C-\><C-N>2<C-w>>
tnoremap <D-,> <C-\><C-N>2<C-w><

" terminal
noremap <D-e> :sp <Bar> term<CR>i
noremap <D-n> i
tnoremap <D-n> <C-\><C-N>

"--- plugins ---
" hop
lua << EOF
require('hop').setup()
EOF
noremap <Leader>w :HopWordAC<CR>
noremap <Leader>b :HopWordBC<CR>
" nerdtree
noremap <Leader>n :NERDTreeToggle<CR>
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

" treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim 
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
}
EOF

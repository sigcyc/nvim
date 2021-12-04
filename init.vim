call plug#begin(stdpath('data') . '/plugged')
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
call plug#end()

set guifont=Monaco:h14

" window management
noremap <D-k> <C-w>k
noremap <D-l> <C-w>l
noremap <D-j> <C-w>j
noremap <D-h> <C-w>h

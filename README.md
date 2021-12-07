# Neovim setup

# install vim
First step: install neovim, neovim-qt
Brew install neovim
Brew install neovim-qt

## Change fonts:
Inside neovim
	set guifont=* # list all guifont

## Shortcuts


### Mac system override

Install hammerspoon
Overwrite the global shortcuts
```
hs.hotkey.bind("cmd", 'h', function()
        hs.eventtap.keyStroke({"ctrl"}, "w", 0)
        hs.timer.usleep(100000)
        hs.eventtap.keyStroke({}, "h", 0)
end)
```
### Terminal shortcuts

## Plugins
First step, use vim-plug for management
Download plug.vim and put it in the autoload directory```
.local/share/nvim/site/autoload/plug.vim
```

### instructions for lua plugin
To run the lua command in vimscript, call
```
lua << EOF
require'nvim-tree'.setup()
EOF
```
### list of essential plugins
gruvbox: colorscheme, put `colorscheme gruvbox` in the same place as init.vim
hop.nvim : a modern EasyMotion
nerdtree : potential replacement by nvim-tree?
#### tagbar
Requirement: install universal-ctags
#### coc.nvim
Requirement: install node
#### fzf
Requirement: install `the_silver_searcher`
#### nvim-treesitter-textobjects
Usage: for getting python functions / classes
Installation:
```
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
```
Also, call
```
:TSInstall python
```
to install the package in python

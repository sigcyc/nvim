# Neovim setup

## install vim
First step: install neovim, neovim-qt
Brew install neovim
Brew install neovim-qt

### neovim-qt
To disable tabline, try in ginit.vim
```
GuiTabline=0
```
If not working, set
```
[General]
ext_linegrid=true
ext_popupmenu=false
ext_tabline=false
```
Check the [link](https://github.com/equalsraf/neovim-qt/issues/589)


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
### linux system clipboard
neovim doesn't provide clipboard support. need to install xclip locally
See the [issue](https://discourse.nixos.org/t/how-to-support-clipboard-for-neovim/9534) and the [installation](https://discourse.nixos.org/t/how-to-support-clipboard-for-neovim/9534)

### Terminal shortcuts
We have the following convention: when we focus on a terminal buffer, the terminal buffer will automatically change into terminal mode. When we focus on another buffer, the terminal buffer will be in insert mode 

[Do not leave on mouse click](https://github.com/neovim/neovim/pull/16604)

## Plugins
First step, use vim-plug for management
Download plug.vim and put it in the autoload directory
```
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
Install plugins:
```
:CocInstall coc-json coc-tsserver
:CocInstall coc-pyright
```
Manual installation to deal with proxy issue
1. Install yarn
2. Download plugin 
3. replace registry.yarnpkg.com by company url
4. yarn install --frozen-lockfile
5. add

coc-pyright:
in CocConfig, set "python.analysis.typeCheckingMode": "off"

coc-snippets:
It can load UltiSnips format snippets. 
:CocCommand snippets.editSnippets
snip formats tutorials can be found [here](https://github.com/SirVer/ultisnips)


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
#### OmniSharp
Install OmniSharp vim plugin and roslyn server
Put the following in init.vim
```
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_selector_findusages = 'fzf'
let g:OmniSharp_server_path = '/home/cheny/workspace/omnisharp-linux-x64/run
```
#### lualine
support to better display terminal filename. We display it as last component of the path:bash. We also define a function to change the name to path:name  

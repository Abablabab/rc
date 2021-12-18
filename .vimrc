" Force vim settings, must be first
set nocompatible

" Spaces and tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab 

set nobackup
set history=50
set ruler
set showcmd
set number
set nowrap
set smarttab
set ruler
set visualbell
set incsearch
set autoindent
set showmatch
set spell

syntax on

" Get it looking nice
set t_Co=256
let mapleader=","
colorscheme industry


" I hate mouse support
set mouse=

if v:version >= 701
    set cursorline
endif

" No one wants GUI toolbars
set guioptions-=T

" More normal backspace behaviour:
set backspace=indent,eol,start

" 'Tab' manipulation shortcuts
:nmap <C-m> <Esc>:tabn<CR>
:nmap <C-b> <Esc>:tabp<CR>
:nmap <C-n> <Esc>:tabe

" Improve menus
highlight Pmenu ctermfg=0 ctermbg=3
highlight PmenuSel ctermfg=0 ctermbg=7
set completeopt=longest,menuone
set wildmode=longest,list,full
set wildmenu

" Auto indent on braces
set smartindent
" Add the ability to autocontinue comments
set formatoptions+=r

" Line length management
set textwidth=80
highlight OverLength ctermbg=52 ctermfg=white guibg=#800000
match OverLength /\%81v.*/

" Highlight trailing whitespace
highlight TrailWs ctermbg=52 ctermfg=white
match TrailWs /\s\+$/

" Don't enforce 80c pain on plaintext
autocmd FileType text :match OverLength //
autocmd FileType text :set textwidth=0

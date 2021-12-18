" Force vim settings, must be first
set nocompatible

" Get it looking nice
set t_Co=256
let mapleader=","
colorscheme industry

" Spaces and tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set autoindent
set cursorline
set history=50
set incsearch
set nobackup
set nowrap
set number
set ruler
set ruler
set showcmd
set showmatch
set smarttab
set visualbell
syntax on

" Spell checking
set spell
hi clear SpellBad
hi SpellBad cterm=underline

" I hate mouse support
set mouse=

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

" Get copy/paste inside WSL
" Is there ANYTHING stackoverflow can't answer!
" https://stackoverflow.com/a/46995591
if !empty($WSL_DISTRO_NAME)
    autocmd TextYankPost * call
    \ system ('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' |  clip.exe')
endif

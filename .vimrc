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

" Auto-indent on braces
set smartindent

" Auto-continue comments
set formatoptions+=r

" Highlight long lines
highlight OverLength ctermbg=52 ctermfg=white
"match OverLength /\%81v.*/
match OverLength /\%>80v/

" Highlight trailing white-space
highlight TrailWs ctermbg=52 ctermfg=white
2match TrailWs /\s\+$/

" Wrap at 80c
set textwidth=80
" Don't enforce 80c pain on plaintext
autocmd FileType text :match OverLength //
autocmd FileType text :set textwidth=0
" We can't wrap python, it breaks things
autocmd FileType python :set textwidth=0

" Get copy/paste inside WSL
" Is there ANYTHING stackoverflow can't answer!
" https://stackoverflow.com/a/46995591
if !empty($WSL_DISTRO_NAME)
    autocmd TextYankPost * call
    \ system ('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' |  clip.exe')
endif

set nocompatible
set t_Co=256
let mapleader=","
colorscheme industry
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set history=50
set incsearch
set nobackup
set nowrap
set number
set ruler
set showcmd
set showmatch
set smarttab
set visualbell
syntax on
set spell
hi clear SpellBad
hi SpellBad cterm=ctermbg=17
set mouse=
set guioptions-=T
set backspace=indent,eol,start
:nmap <C-m> <Esc>:tabn<CR>
:nmap <C-b> <Esc>:tabp<CR>
:nmap <C-n> <Esc>:tabe
highlight Pmenu ctermfg=0 ctermbg=3
highlight PmenuSel ctermfg=0 ctermbg=7
set completeopt=longest,menuone
set wildmode=longest,list,full
set wildmenu
set smartindent
set formatoptions+=r

" Choice Highlights
highlight OverLength ctermbg=53 ctermfg=white
match OverLength /\%>81v/
highlight TrailWs ctermbg=52 ctermfg=white
2match TrailWs /\s\+$/
hi CursorLine   cterm=bold ctermbg=17
hi CursorColumn cterm=bold ctermbg=17
set cursorline
set cursorcolumn

" Get copy/paste inside WSL
" via https://stackoverflow.com/a/46995591
if !empty($WSL_DISTRO_NAME)
    autocmd TextYankPost * call
    \ system ('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' |  clip.exe')
endif

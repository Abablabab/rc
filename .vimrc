" Force vim settings, must be first
set nocompatible

" A bunch of things vim would already everywhere but redhat
" Seriously, this is even default on WINDOWS
set nobackup
set history=50
set ruler     
set showcmd   

set t_Co=256
let mapleader=","
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"

set number

if has('gui_running')
    colorscheme github
    set background=light
else
    colorscheme solarized
    set background=dark
endif

syntax on

" I hate mouse support
set mouse=

set nowrap
set smarttab
set ruler
set vb
set incsearch
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab " Spaces instead of tabs
set showmatch

if v:version >= 700 
    set cursorline  
endif               

" No one wants GUI toolbars
set guioptions-=T

" More normal backspace behaviour:
set backspace=indent,eol,start    

" Tab manipulation shortcuts
:nmap <C-m> <Esc>:tabn<CR>
:nmap <C-b> <Esc>:tabp<CR>
:nmap <C-n> <Esc>:tabe 

" make the completion menus readable  
highlight Pmenu ctermfg=0 ctermbg=3   
highlight PmenuSel ctermfg=0 ctermbg=7

" Tab completion menus
set wildmode=longest,list,full
set wildmenu                  

function! Rules_generic()
    " Auto indent on braces 
    set smartindent
    " Add the ability to autocontinue comments 
    set formatoptions+=r
    set spell
endfunction

function! MyFolds()
    let thisline = getline(v:lnum)
    " according to the 'fold-expr' documentation. 
    " doing this makes me a very bad man, 'a', 's', '=' are 'very slow'

    "" Really primitive cuddled else detection
    "" One day this will probably have to be way more complex
    "" Perhaps simplifying this to always match odd { or }s? 
    if match(thisline, '^\s*}.*{') >=0 "cuddled statement (probably)
        return "="
    elseif match(thisline, '\({.*}\s*\)*.*{\(\(\s*$\)\|\(//.*\)$\)') >= 0 "start { block
        return "a1" "level +1
    elseif match(thisline, '{.*}\;\?$') >=0 "single line block
        return "="
    elseif match(thisline, '}\;\?\s*$') >=0 "end of block
        return "s1" "level -1
    else 
        return "=" " keeps the same fold level
    endif
endfunction

function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 1
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction 

function! Rules_AllCode()
    " Line length management
    set textwidth=80
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929 
    match OverLength /\%81v.*/
    " let's us use :make
    set autowrite
    " build with F5, but also force nice printing of results
    nmap <F5>   :!clear<CR>:make<CR>
    " 're-build' just shows the status line message
    nmap <F6>   :!clear<CR>:make<CR><CR>
    set foldcolumn=5
    set foldmethod=expr
    set foldexpr=MyFolds()
    set foldtext=MyFoldText()
    set foldlevel=1 " Unwrap all folds to level 
    nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
endfunction  

function! Rules_perl()
    call Rules_AllCode()
    set makeprg=perl\ -c\ %\ $*
    set errorformat=%f:%l:%m
endfunction

function! Rules_go()
    call Rules_AllCode()
    set makeprg=GOPATH=%:p:h\ go\ build\ %\ $*
endfunction

function! Rules_python2()
    call Rules_AllCode()
    set makeprg=python2\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
    set errorformat=%f:%l:%m
    "set errorformat=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
    nmap <F7> :w <bar> exec '!clear && python2 '.shellescape('%')<CR>
endfunction

function! Rules_cpp()
    call Rules_AllCode()
    set tabstop=2
    set shiftwidth=2
    set softtabstop=2
endfunction

" If there's a set filetype, it's probably not plaintext
" so set some generic development rules
autocmd FileType *      call Rules_generic()
autocmd FileType perl   call Rules_perl()
autocmd FileType go     call Rules_go()
autocmd FileType python call Rules_python2()
autocmd FileType cpp    call Rules_cpp()

" autoCmd BufNewFile,BufRead *.cpp set taco
" ^^ also works as fair replacement for FileType

" Fix vim color leaking
" Can throw some harmless errors on exit
au VimLeave * reset && clear   


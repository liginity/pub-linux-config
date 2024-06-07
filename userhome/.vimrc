" set
" line number, ruler is position:x,y
set nu ruler
" could use mouse in terminal vim
set mouse=a
" show commands in status bar, and every window has a status bar
set showcmd laststatus=2
" tab
set softtabstop=4 tabstop=4 expandtab shiftwidth=4 smarttab
" indent
set autoindent cindent smartindent
" encoding
set encoding=utf-8
" GUI font (source code pro)
set guifont=Source\ Code\ Pro:h14
" background dark, the color feels better
"set background=dark
" backspace: solve the problem of being unable to backspace
" when used msys2 vim in powershell ( didn't know cause )
set backspace=2
set foldenable foldmethod=manual
"set formatoptions-=cro
set noautoread nobackup noswapfile confirm
set magic iskeyword+=_
"set selection=exclusive
set selectmode=mouse,key
"set nomodeline
set scrolloff=5
set hlsearch
"setlocal spell
"set spelllang=en_us
"inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

syntax on
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
"set wrapscan ignorecase incsearch hlsearch

" au or autocmd
autocmd FileType sh,javascript,html,css,scss,yaml,ruby,vb,sql set tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType html,htmldjango,css,scss,make,text set noexpandtab
"autocmd FileType * set formatoptions-=cro
"autocmd BufNewFile *.[ch],*.[ch]pp exec ":call CAddFileInfo()"
"autocmd BufWritePre * :%s/^\s\+$//e " Only trim empty lines
"autocmd FileType html,xml,css setlocal tabstop=2
au FileType html setlocal tabstop=2 shiftwidth=2

" NOTE the above settings are good for basic usage.

" maps
"nnoremap <space> za (open fold)
let mapleader=" "
map <Leader> <NOP>
" map window command
noremap <Leader>wh <C-W>h
noremap <Leader>wj <C-W>j
noremap <Leader>wk <C-W>k
noremap <Leader>wl <C-W>l
" previous window
noremap <Leader><TAB> <C-W>p
noremap <Leader>ww <C-W>p
" close all but current window
noremap <Leader>wo <C-W>o
" quit current window
noremap <Leader>wq <C-W>q
" split window horizentally and vertically
noremap <Leader>w/ :vsplit<CR>
noremap <Leader>w- :split<CR>
" buffers
noremap <Leader>bp :bp<CR>
noremap <Leader>bn :bn<CR>
" tabs
noremap <Leader>tp :tabp<CR>
noremap <Leader>tn :tabn<CR>


" functions and maps
""""""""""
"Quickly Run
""""""""""
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    " I found the way to write, simple, in the document
    exec "update"
    if &filetype=='c'
        exec "!gcc % -o %:r.out && time ./%:r.out"
    elseif &filetype=='cpp'
        exec "!g++ % -o %:r.out && time ./%:r.out"
    elseif &filetype=='sh'
        exec "!time bash %"
    elseif &filetype=='python'
        exec "!time python3 %"
    elseif &filetype=='tex'
        exec "!latex % && latex %"
    endif
endfunc

""""""""""
"Special Run
""""""""""
map <F6> :call SpecialRun()<CR>
func! SpecialRun()
    " for example, root macro with .cpp
    " or ctex with .tex
    exec "update"
    if &filetype=='cpp'
        exec "!root.exe %"
    elseif &filetype=='tex'
        exec "!xelatex %"
        exec "!xelatex %"
    endif
endfunc


"func! Automaticpep8()
"    exec "w"
"    if &filetype=='python'
"        exec "!autopep8 --in-place --aggressive --aggressive %"
"    endif
"endfunc

func! CAddFileInfo()
    "I can add write this as LICENSE one day.
    call setline(1, "// File: ".expand("%:t"))
    call append(line("."), "// Author: liginity")
    call append(line(".")+1, "")
    normal G
endfunc

" Commenting blocks of code.
"autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
"autocmd FileType sh,zsh,ruby,python   let b:comment_leader = '# '
"autocmd FileType conf,fstab       let b:comment_leader = '# '
"autocmd FileType tex              let b:comment_leader = '% '
"autocmd FileType mail             let b:comment_leader = '> '
"autocmd FileType vim              let b:comment_leader = '" '
"noremap <silent> <Leader>cl :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
"noremap <silent> <Leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

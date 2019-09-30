" set nocompatible              " be iMproved, required
" filetype off                  " required

" set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
" Plugin 'VundleVim/Vundle.vim'
" Plugin 'Valloric/YouCompleteMe'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
" call vundle#end()            " required
" filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

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
set background=dark
" backspace: solve the problem of being unable to backspace
" when used msys2 vim in powershell ( didn't know cause )
set backspace=2
set foldenable foldmethod=manual
" set formatoptions-=cro
set noautoread nobackup noswapfile confirm
set magic iskeyword+=_
set selection=exclusive selectmode=mouse,key
" set nomodeline

syntax on
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
" set wrapscan ignorecase incsearch hlsearch
" au or autocmd
autocmd FileType sh,javascript,html,css,scss,yaml,ruby,vb,sql set tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType html,htmldjango,css,scss,make,text set noexpandtab
" autocmd FileType * set formatoptions-=cro
autocmd BufNewFile *.[ch],*.[ch]pp exec ":call CAddFileInfo()"
" autocmd BufWritePre * :%s/^\s\+$//e " Only trim empty lines
" autocmd FileType html,xml,css setlocal tabstop=2
au FileType html set tabstop=2 shiftwidth=2

" maps
nnoremap <space> za
" let mapleader=" "
" map <Leader> <NOP>
" noremap <Leader><Left> <C-W>h
" noremap <Leader><Down> <C-W>j
" noremap <Leader><Up> <C-W>k
" noremap <Leader><Right> <C-W>l

" map q <NOP>
" map <C-Z> <C-X>
" map <C-S> :w<CR>
" imap <C-S> <Esc>:w<CR>a
" map <C-h> <C-W>h
" map <C-j> <C-W>j
" map <C-k> <C-W>k
" map <C-l> <C-W>l
" map <C-Left> <C-W>h
" map <C-Down> <C-W>j
" map <C-Up> <C-W>k
" map <C-Right> <C-W>l

" functions and maps
""""""""""
"Quickly Run
""""""""""
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype=='c'
        exec "!g++ % -o %:r.out"
        exec "!time ./%:r.out"
    elseif &filetype=='cpp'
        exec "!g++ % -o %:r.out"
        exec "time ./%:r.out"
    elseif &filetype=='sh'
        :!time bash %
    elseif &filetype=='python'
        exec "!time python3 %"
    endif
endfunc


" func! Automaticpep8()
"     exec "w"
"     if &filetype=='python'
"         exec "!autopep8 --in-place --aggressive --aggressive %"
"     endif
" endfunc

func! CAddFileInfo()
    call setline(1, "// File: ".expand("%:t"))
    call append(line("."), "// Author: liginity")
    call append(line(".")+1, "")
    normal G
endfunc

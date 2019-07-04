set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
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
filetype plugin indent on    " required
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
set nu
set ruler
set mouse=a
set showcmd
set laststatus=2

set softtabstop=4
set tabstop=4
set expandtab
set shiftwidth=4

set autoindent
set cindent
set smartindent
set encoding=utf-8

set guifont=Source\ Code\ Pro:h14

""""""""""
"Quickly Run
""""""""""
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype=='c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype=='cpp'
        exec "!g++ % -o %<"
        exec "time ./%<"
    elseif &filetype=='sh'
        :!time bash %
    elseif &filetype=='python'
        exec "!time python3 %"
    endif
endfunc

nnoremap <space> za

" func! Automaticpep8()
"     exec "w"
"     if &filetype=='python'
"         exec "!autopep8 --in-place --aggressive --aggressive %"
"     endif
" endfunc

" autocmd FileType html,xml,css setlocal tabstop=2
au FileType html set tabstop=2
au FileType html set shiftwidth=2

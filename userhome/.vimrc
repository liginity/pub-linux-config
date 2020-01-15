" install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" Make sure you use single quotes
Plug 'junegunn/vim-plug'
" Plug 'Valloric/YouCompleteMe'
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
" supertab helps to make ultisnips and vim-snippets works together
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" Plug 'ervandew/supertab'

" Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.sh' }
" Plug 'lervag/vimtex'
"     let g:tex_flavor='latex'
"     let g:vimtex_view_method='zathura'
"     let g:vimtex_quickfix_mode=0
" 
" Plug 'KeitaNakamura/tex-conceal.vim'
"     set conceallevel=1
"     let g:tex_conceal='abdmg'

" for commenting
Plug 'preservim/nerdcommenter'
" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

" Initialize plugin system
call plug#end()


" ultisnip setting
let g:UltiSnipsEditSplit="vertical"
" make YCM compatible with UltiSnips (using supertab)
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" let g:ycm_global_ycm_extra_conf = "~/.global.ycm_extra_conf.py"

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
" set selection=exclusive
set selectmode=mouse,key
" set nomodeline
set scrolloff=5
:set hlsearch
" setlocal spell
" set spelllang=en_us
" inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

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
" autocmd BufNewFile *.[ch],*.[ch]pp exec ":call CAddFileInfo()"
" autocmd BufWritePre * :%s/^\s\+$//e " Only trim empty lines
" autocmd FileType html,xml,css setlocal tabstop=2
au FileType html setlocal tabstop=2 shiftwidth=2

" maps
" nnoremap <space> za (open fold)
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


" func! Automaticpep8()
"     exec "w"
"     if &filetype=='python'
"         exec "!autopep8 --in-place --aggressive --aggressive %"
"     endif
" endfunc

func! CAddFileInfo()
    "I can add write this as LICENSE one day.
    call setline(1, "// File: ".expand("%:t"))
    call append(line("."), "// Author: liginity")
    call append(line(".")+1, "")
    normal G
endfunc

" Commenting blocks of code.
" autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
" autocmd FileType sh,zsh,ruby,python   let b:comment_leader = '# '
" autocmd FileType conf,fstab       let b:comment_leader = '# '
" autocmd FileType tex              let b:comment_leader = '% '
" autocmd FileType mail             let b:comment_leader = '> '
" autocmd FileType vim              let b:comment_leader = '" '
" noremap <silent> <Leader>cl :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
" noremap <silent> <Leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

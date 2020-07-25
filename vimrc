set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

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

Plug 'vim-scripts/L9'
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'
Plug 'vim-scripts/taglist.vim'
"Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'Lokaltog/vim-powerline'
Plug 'scrooloose/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'tell-k/vim-autopep8'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
"Plug 'ervandew/supertab'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fatih/vim-go'
Plug 'vim-scripts/Mark--Karkat'
Plug 'jstemmer/gotags'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'

call plug#end()            " required

filetype plugin indent on    " required

syntax enable
set hlsearch
set gcr=a:block-blinkon0
set backspace=indent,eol,start

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set cindent
set nu
set colorcolumn=100
" set foldmethod=indent

let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1

set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gb18030,gbk,big5,utf-16,latin1
set fileencoding=utf-8
set termencoding=utf-8 

let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<cr>
highlight Comment ctermfg=green guifg=green
autocmd BufReadPost *
\ if line("'\"")>0&&line("'\"")<=line("$") |
\	exe "normal g'\"" |
\ endif

let Tlist_Auto_Open = 0
let Tlist_WinWidth = 50

" Highlight current line
" au WinLeave * set nocursorline nocursorcolumn
" au WinEnter * set cursorline cursorcolumn
" set cursorline cursorcolumn
set cursorline
"set foldmethod=indent

" Unified color scheme (default: dark)
colo seoul256

" ycm
let g:ycm_python_interpreter_path = '/home/weijunyi/root/bin/python'
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
"let g:ycm_global_ycm_extra_conf = '~/.global_extra_conf.py'

let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

" Goto definition
map <f2> :YcmCompleter GoTo<CR>

let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
nmap <tab> :bn<cr>
nmap <s-tab> :bp<cr>

" cscope configuration
if filereadable("cscope.out")
    cs add cscope.out
endif
nmap <f7> :cs f s<c-r>=expand("<cword>")<cr><cr>
" ---------------------------------- "
" Common
" ---------------------------------- "

" Python shiftwidth, tabstop, softtabstop
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4
autocmd FileType go set sw=4
autocmd FileType go set ts=4
autocmd FileType go set sts=4

" set mapleader to a easier typable key
" let mapleader = ","
" set mouse=i

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
            \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }
nmap <F9> :TagbarToggle<CR>

" gutentags 配置
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

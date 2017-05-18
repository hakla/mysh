" Vundle {{{
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" }}}

" Plugins {{{
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" sensible defaults
Plugin 'tpope/vim-sensible'

" color scheme
Plugin 'sjl/badwolf'
Plugin 'tomasr/molokai'

" gundo
Plugin 'sjl/gundo.vim'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Raimondi/delimitMate'

" Plugin 'Valloric/YouCompleteMe'

" multiple cursors
Plugin 'terryma/vim-multiple-cursors'

let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-0>'

" vue js
Plugin 'posva/vim-vue'

" NERDTree
Plugin 'scrooloose/nerdtree'

" vim-notes
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'


" open-browser
Plugin 'tyru/open-browser.vim'


" }}}

" Vundle end {{{
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" }}}

" Colors {{{
colorscheme badwolf         " awesome colorscheme
" }}}

" Stuff {{{
syntax enable           " enable syntax processing

set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set expandtab       " tabs are spaces

set number              " show line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line

" set the color of the cursorline
hi CursorLine cterm=none ctermbg=0 ctermfg=none

filetype indent on      " load filetype-specific indent files

set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
" }}}

" Search {{{
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" }}}

" Fold {{{
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level

" space open/closes folds
nnoremap <space> za
" }}}

" custom functions {{{
" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
" }}}

" Moving about {{{
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" }}}

" Leader shortcuts {{{
let mapleader=","       " leader is comma

" jk is escape
inoremap jk <esc>

" map vim-notes
nnoremap <leader>nu :Note Übersicht<CR>

" turn off search highlight
nnoremap <leader>. :noh<CR>

" open link under cursor
nnoremap <leader>gf <Plug>(openbrowser-smart-search)

" open notes
nnoremap <leader>nn :Note Übersicht<CR>
nnoremap <leader>nt :Note todo<CR>
vnoremap <leader>nf :w!<CR>:NoteFromSelectedText<CR>

" todo characters
nnoremap <leader>+ a <C-v>u2713<ESC>

" replace currently highlighted text
vnoremap <leader>rtl "ry:s/<C-r>r//g<left><left>
vnoremap <leader>rtg "ry:%s/<C-r>r//g<left><left>
" }}}

" Gundo {{{
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
" }}}

" Edit and reload .vimrc {{{
" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" }}}

" Session {{{
" save session
nnoremap <leader>s :mksession!<CR>
" }}}}

" ag {{{
" open ag.vim
nnoremap <leader>a :Ag
" }}}}

" ctrl-p {{{
" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
" }}}

" autocmd {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    " autocmd BufWritePre *.php,*.py,*{.js,.json},*.txt,*.hs,*.java,*.md
    "             \:call <SID>StripTrailingWhitespaces()
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufEnter *.js setlocal tabstop=2
    autocmd BufEnter *.js setlocal shiftwidth=2
    autocmd BufEnter *.js setlocal softtabstop=2
augroup END
" }}}

" Backup stuff {{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" }}}

" Splitting {{{

" Moving around in splits {{{
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" }}}

" Where to open splits {{{
set splitbelow
set splitright
" }}}

" }}} 

" vim:foldmethod=marker:foldlevel=0

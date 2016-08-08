set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin('~/.vim/bundle/')

Plugin 'VundleVim/Vundle.vim'

" plugins
Plugin 'vim-scripts/sessionman.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'chriskempson/base16-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-scripts/mru.vim'
Plugin 'bkad/CamelCaseMotion'
Plugin 'vim-scripts/argtextobj.vim'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'scrooloose/nerdcommenter'
Plugin 'pangloss/vim-javascript'
Plugin 'mattn/emmet-vim'
Plugin 'vim-scripts/netrw.vim'
Plugin 'edkolev/promptline.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'valloric/YouCompleteMe'
Plugin 'jeaye/color_coded'
Plugin 'rdnetto/YCM-Generator'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set encoding=utf-8

set nocompatible        " use vim defaults
set scrolloff=3         " keep 3 lines when scrolling
set ai                  " set auto-indenting on for programming

set showcmd             " display incomplete commands
set nobackup            " do not keep a backup file
set number              " show line numbers
set ruler               " show the current row and column

set hlsearch            " highlight searches
set incsearch           " do incremental searching
set showmatch           " jump to matches when entering regexp
set ignorecase          " ignore case when searching
set smartcase           " no ignorecase if Uppercase char present

set visualbell t_vb=    " turn off error beep/flash
set novisualbell        " turn off visual bell

set exrc    " allow project-specific .vimrc
set secure  " disallow bad things in .vimrc

set backspace=indent,eol,start  " make that backspace key work the way it should

syntax on               " turn syntax highlighting on by default

set ts=2				" set tabs to 4 spaces
set expandtab			" no tabs :)
set autoindent			" carry indent to next line
set shiftwidth=2		" tab length

let mapleader = ","
let maplocalleader = "\\"
set clipboard=unnamed	" share vim clipboard w windows
let base16colorspace=256
colorscheme base16-tomorrow-night " colors!
set background=dark			" readability!
let python_highlight_all=1	" syntax highlighting
set go=m					" hide menus

set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" key combinations

nnoremap <Esc> :noh<CR>
map <Leader>py :w<CR>:!start /c python %
map <Leader>ioa :!start cmd /c cd ionic && ionic run android -l<CR>
map <Leader>iob :!start cmd /c cd ionic && ionic serve -l<CR>
map <Leader>n :Lexplore<CR>
noremap j gj
noremap k gk
inoremap kj <Esc>
call camelcasemotion#CreateMotionMappings('<leader>')   " camelcasemotion
nnoremap <F10> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nnoremap <F11> :YcmCompleter FixIt<cr>

" Window Navigation Things

set splitbelow
set splitright
set hidden

nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <leader>h :bp<CR>
nnoremap <leader>l :bn<CR>

nnoremap <C-c> :bp\|bd #<CR>

" CtrlP
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Airline
set laststatus=2								" show airline
let g:airline#extensions#tabline#enabled = 1	" show tabline
let g:airline_powerline_fonts = 1				" use fonts
set guifont=Sauce\ Code\ Powerline\ 12

" YCM
set completeopt-=preview

" Netrw exploring thingymajig
let g:netrw_winsize = -28 " absolute width of netrw window
let g:netrw_banner = 0 " do not display info on the top of window
let g:netrw_liststyle = 3 " tree-view
let g:netrw_sort_sequence = '[\/]$,*' " sort is affecting only: directories on the top, files below
let g:netrw_browse_split = 4 " use the previous window to open file

com!  -nargs=* -bar -bang -complete=dir  Lexplore  call Lexplore(<q-args>, <bang>0)

fun! Lexplore(dir, right)
  if exists("t:netrw_lexbufnr")
    " close down netrw explorer window
    let lexwinnr = bufwinnr(t:netrw_lexbufnr)
    if lexwinnr != -1
      let curwin = winnr()
      exe lexwinnr."wincmd w"
      close
      exe curwin."wincmd w"
    endif
    unlet t:netrw_lexbufnr

  else
    " open netrw explorer window in the dir of current file
    " (even on remote files)
    let path = substitute(exists("b:netrw_curdir")? b:netrw_curdir : expand("%:p"), '^\(.*[/\\]\)[^/\\]*$','\1','e')
    exe (a:right? "botright" : "topleft")." vertical ".((g:netrw_winsize > 0)? (g:netrw_winsize*winwidth(0))/100 : -g:netrw_winsize) . " new"
    if a:dir != ""
      exe "Explore ".a:dir
    else
      exe "Explore ".path
    endif
    setlocal winfixwidth
    let t:netrw_lexbufnr = bufnr("%")
  endif
endfun

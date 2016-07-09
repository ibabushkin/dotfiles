" use vim settings, rather than vi settings (much better!)
" this must be first, because it changes other options as a side effect
set nocompatible

" default encoding
set encoding=utf-8

" don't use backup files
set nobackup

" keep a history of 50 commands
set history=50

" show current file position in the status line
set ruler

" don't use ex mode
map Q <NOP>

" <C-U> in insert mode deletes a lot.  Use <C-G> u to first break undo,
" so that you can undo <C-U> after inserting a line break
inoremap <C-U> <C-G>u<C-U>

" use syntax highlight
syntax on

" use incremental search and highlight results
set incsearch
set hlsearch

if has("autocmd")
  " vundle will shit it's pants if we don't
  filetype off

  " init vundle
  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()

  " our plugins
  Bundle "gmarik/vundle"
  Bundle "godlygeek/tabular"
  Bundle "dhruvasagar/vim-table-mode"
  Bundle "MarcWeber/vim-addon-mw-utils"
  Bundle "tomtom/tlib_vim"
  Bundle "garbas/vim-snipmate"
  Bundle "honza/vim-snippets"
  Bundle "ibabushkin/vim-markdown"
  Bundle "unblevable/quick-scope"
  Bundle "rust-lang/rust.vim"
  Bundle "neovimhaskell/haskell-vim"
  Bundle "cespare/vim-toml"

  filetype plugin indent on

  augroup vimrcEx
  au!

  autocmd FileType text setlocal textwidth=78

  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END
else
  set autoindent
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" give us rad relative line numbers and show us the current absolute
set number
set relativenumber

" use system clipboard
set clipboard=unnamedplus

" show some special characters
set list
set listchars=tab:▸\ ,eol:¬

" show us the commands we type
set showcmd

" go to a matching window if we switch to a new buffer
set switchbuf=usetab

" only redraw when commands have finished
set lazyredraw

" redraw status line as necessary
set laststatus=2

" snipmate settings
let g:snips_author = "Inokentiy Babushkin"
let g:snips_email = "inokentiy.babushkin@googlemail.com"
let g:snips_github = "http://www.github.com/ibabushkin"

" spelling languages
set spelllang=en,de

" use jj to get back to insert mode
inoremap jj <ESC>

" get rid of arrow keys and backspace
inoremap <BS> <NOP>
noremap <Up> <NOP>
vnoremap <Up> <NOP>
inoremap <Up> <NOP>
noremap <Down> <NOP>
vnoremap <Down> <NOP>
inoremap <Down> <NOP>
noremap <Left> <NOP>
vnoremap <Left> <NOP>
inoremap <Left> <NOP>
noremap <Right> <NOP>
vnoremap <Right> <NOP>
inoremap <Right> <NOP>

" give us a nice margin to the window border
set scrolloff=16

" use H and L to move to the beginning and end of a line, respectively
nnoremap H ^
onoremap H ^
xnoremap H ^
nnoremap L $
onoremap L $
xnoremap L $

" TODO: find out what this does
map <ESC>Od <C-Left>
map <ESC>Oc <C-Right>

" rebind arrowkeys to more useful things
noremap <Left> :tabp<CR>
noremap <Right> :tabn<CR>
noremap <Up> :bn<CR>
noremap <Down> :bp<CR>

" use gb as a quick way to move between buffers
nnoremap gb :ls<CR>:b<Space>

" haskell highlighting and indentation
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 4

" map timestamp functions to keys
nnoremap <C-T> :InsertTimestamp
nnoremap <C-Z> :InsertTimestampExact

" use our colorscheme
colorscheme wombat

" change the cursor appearance depending on mode
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
" and hide the usual indicator
set noshowmode

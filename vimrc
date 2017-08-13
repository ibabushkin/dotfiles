" if in vim, and not neovim:
" use vim settings, rather than vi settings (much better!)
" this must be first, because it changes other options as a side effect
set nocompatible

" vundle will shit it's pants if we don't
filetype off

" init vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" our plugins
Bundle "gmarik/vundle"
Bundle "godlygeek/tabular"
Bundle "dhruvasagar/vim-table-mode"
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "ibabushkin/vim-markdown"
Bundle "unblevable/quick-scope"
Bundle "rust-lang/rust.vim"
Bundle "neovimhaskell/haskell-vim"
Bundle "cespare/vim-toml"
Bundle "neomake/neomake"
Bundle "tpope/vim-commentary"

call vundle#end()

set encoding=utf-8
set nobackup
set history=50
syntax on
set incsearch
set hlsearch
set number
set relativenumber
set clipboard=unnamedplus
set ignorecase
set smartcase
set wrap
set nomodeline

" highlight stuff overflowing textwidth
set colorcolumn=+1

" allow editing multiple buffers properly
set hidden

" show some nonprintable characters
set list
set listchars=tab:>\ ,eol:¬

" show us the commands we type
set showcmd

" go to a matching window if we switch to a new buffer
set switchbuf=usetab

" only redraw when commands have finished
set lazyredraw

" redraw status line as necessary
set laststatus=2

" spelling languages
set spelllang=en,de

" show current file position in the status line
set ruler

" give us a nice margin to the window border
set scrolloff=16

" isabelle filetype detection
filetype plugin indent on
augroup filetypedetect
  au BufRead,BufNewFile *.thy setfiletype isabelle
augroup END

" jump to the last position after a restart
autocmd BufReadPost * if line("'\"") | exe "'\"" | endif

" equalize splits on window resize
autocmd VimResized * wincmd =

" don't use ex mode
map Q <NOP>

" <C-U> in insert mode deletes a lot.  Use <C-G> u to first break undo,
" so that you can undo <C-U> after inserting a line break
inoremap <C-U> <C-G>u<C-U>

" insert tab character when needed
inoremap <S-Tab> <C-V><Tab>

" insert an enter in a more convenient fashion
inoremap <C-O> <CR>
noremap <C-O> <CR>
vnoremap <C-O> <CR>
xnoremap <C-O> <CR>
snoremap <C-O> <CR>
onoremap <C-O> <CR>
lnoremap <C-O> <CR>
cnoremap <C-O> <CR>

" history navigation in a more convenient fashion
cnoremap <C-K> <Up>
cnoremap <C-J> <Down>

" quick jumping to matching bracket
nnoremap <tab> %
vnoremap <tab> %

" map our leader key
let mapleader = " "
let g:mapleader = " "

" clear search
nnoremap <leader>/ :nohlsearch<Bar>:echo<CR>

" map timestamp functions to keys
nnoremap <leader>T :InsertTimestamp<Space>
nnoremap <leader>Z :InsertTimestampExact<Space>

" map some keys to perform longer movements
nnoremap <leader>h ^
onoremap <leader>h ^
xnoremap <leader>h ^
nnoremap <leader>l $
onoremap <leader>l $
xnoremap <leader>l $

" a quick way to move between buffers
nnoremap <leader>b :ls<CR>:b<Space>

" a less quick, but similarly useful way to move between marks
nnoremap <leader>' :marks<CR>:normal!'
nnoremap <leader>` :marks<CR>:normal!`

" reload configuration file
nnoremap <leader>v :so ~/.vimrc<CR>

" haskell highlighting and indentation
let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1
let g:haskell_enable_static_pointers = 1
let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 4

" run neomake on save
autocmd! BufWritePost * Neomake

" enabled makers for haskell
let g:neomake_haskell_enabled_makers = ['hlint', 'hdevtools']

" disabled rust and cpp makers
let g:neomake_rust_enabled_makers = []
let g:neomake_cpp_enabled_makers = []

" parameters for clang
let g:neomake_cpp_clang_maker = {
    \ 'args': ['-std=c++14', '-Wall', '-Wextra', '-Weverything', '-pedantic']
    \ }

" make neomake's error symbols nicer
let g:neomake_error_sign = {'text': 'E', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': 'W', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': 'M', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign = {'text': 'M', 'texthl': 'NeomakeInfoSign'}

" highlighting of neomake's warnings and errors
augroup my_error_signs
  au!
  autocmd ColorScheme * hi NeomakeErrorSign ctermbg=black
augroup END
augroup my_warning_signs
  au!
  autocmd ColorScheme * hi NeomakeWarningSign ctermbg=black
augroup END
augroup my_message_signs
  au!
  autocmd ColorScheme * hi NeomakeMessageSign ctermbg=none
augroup my_info_signs
  au!
  autocmd ColorScheme * hi NeomakeInfoSign ctermbg=none

" set up our file explorer
let g:netrw_banner = 0
let g:netrw_winsize = 30

" change the cursor appearance depending on mode and hide the usual indicator
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
set noshowmode

" for old versions of nvim
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" let &t_SI = "\<Esc>[6 q"
" let &t_SR = "\<Esc>[4 q"
" let &t_EI = "\<Esc>[2 q"

" highlighting done small
hi StatusLine ctermfg=252 ctermbg=8
hi StatusLineNC ctermfg=255 ctermbg=8
hi VertSplit  ctermfg=252 ctermbg=8
hi CursorLine ctermbg=255 cterm=none
hi CursorColumn ctermbg=255 cterm=none
set cursorcolumn
set cursorline

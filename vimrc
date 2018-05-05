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

set cursorcolumn
set cursorline

" highlighting done small
" colors adapted from nofrils-light (https://github.com/robertmeta/nofrils)

hi clear
if exists("syntax_on")
    syntax reset
endif

" Baseline
hi Normal term=NONE cterm=NONE ctermfg=black ctermbg=256 gui=NONE guifg=#000000 guibg=#E4E4E4

" Faded
hi ColorColumn term=NONE cterm=NONE ctermfg=NONE ctermbg=253 gui=NONE guifg=NONE guibg=#DADADA
hi Comment term=NONE cterm=NONE ctermfg=4 ctermbg=NONE gui=NONE guifg=#A8A8A8 guibg=NONE
hi FoldColumn term=NONE cterm=NONE ctermfg=248 ctermbg=NONE gui=NONE guifg=#A8A8A8 guibg=NONE
hi Folded term=NONE cterm=NONE ctermfg=240 ctermbg=NONE gui=NONE guifg=#585858 guibg=NONE
hi LineNr term=NONE cterm=NONE ctermfg=8 ctermbg=bg gui=NONE guifg=#A8A8A8 guibg=NONE
hi NonText term=NONE cterm=NONE ctermfg=248 ctermbg=NONE gui=NONE guifg=#A8A8A8 guibg=NONE
hi SignColumn term=NONE cterm=NONE ctermfg=240 ctermbg=bg gui=NONE guifg=#585858 guibg=bg
hi SpecialKey term=NONE cterm=NONE ctermfg=240 ctermbg=bg gui=NONE guifg=#585858 guibg=bg
hi StatusLineNC term=NONE cterm=NONE ctermfg=8 ctermbg=255 gui=NONE guifg=fg guibg=#A8A8A8
hi VertSplit term=NONE cterm=NONE ctermfg=fg ctermbg=252 gui=NONE guifg=fg guibg=#A8A8A8

" Highlighted
hi CursorColumn term=NONE cterm=NONE ctermfg=NONE ctermbg=255 gui=NONE guifg=NONE guibg=#DADADA
hi CursorIM term=NONE cterm=NONE ctermfg=fg ctermbg=4 gui=NONE guifg=fg guibg=#00FFFF
hi CursorLineNr term=NONE cterm=NONE ctermfg=NONE ctermbg=255 gui=NONE guifg=NONE guibg=white
hi CursorLine term=NONE cterm=NONE ctermfg=NONE ctermbg=255 gui=NONE guifg=NONE guibg=#DADADA
hi Cursor term=NONE cterm=NONE ctermfg=fg ctermbg=4 gui=NONE guifg=fg guibg=#00FFFF
hi Directory term=NONE cterm=NONE ctermfg=53 ctermbg=NONE gui=NONE guifg=#5F005F guibg=NONE
hi ErrorMsg term=NONE cterm=NONE ctermfg=9 ctermbg=white gui=NONE guifg=#FF5555 guibg=white
hi Error term=NONE cterm=NONE ctermfg=9 ctermbg=white gui=NONE guifg=#FF5555 guibg=white
hi IncSearch term=NONE cterm=NONE ctermfg=black ctermbg=252 gui=NONE guifg=white guibg=#008000
hi MatchParen term=NONE cterm=NONE ctermfg=15 ctermbg=4 gui=NONE guifg=#ffffff guibg=#000080
hi ModeMsg term=NONE cterm=NONE ctermfg=53 ctermbg=NONE gui=NONE guifg=#5F005F guibg=NONE
hi MoreMsg term=NONE cterm=NONE ctermfg=53 ctermbg=NONE gui=NONE guifg=#5F005F guibg=NONE
hi PmenuSel term=NONE cterm=NONE ctermfg=fg ctermbg=13 gui=NONE guifg=fg guibg=#FF00FF
hi Question term=NONE cterm=NONE ctermfg=53 ctermbg=NONE gui=NONE guifg=#5F005F guibg=NONE
hi Search term=NONE cterm=NONE ctermfg=black ctermbg=252 gui=NONE guifg=white guibg=#00CDCD
hi StatusLine term=NONE cterm=bold ctermfg=8 ctermbg=252 gui=NONE guifg=white guibg=#000000
hi Todo term=NONE cterm=NONE ctermfg=2 ctermbg=NONE gui=NONE guifg=#008000 guibg=NONE
hi WarningMsg term=NONE cterm=NONE ctermfg=9 ctermbg=white gui=NONE guifg=#FF5555 guibg=white
hi WildMenu term=NONE cterm=NONE ctermfg=black ctermbg=white gui=NONE guifg=#000000 guibg=white

" Reversed
hi PmenuSbar term=reverse cterm=reverse ctermfg=NONE ctermbg=NONE gui=reverse guifg=NONE guibg=NONE
hi Pmenu term=reverse cterm=reverse ctermfg=NONE ctermbg=NONE gui=reverse guifg=NONE guibg=NONE
hi PmenuThumb term=reverse cterm=reverse ctermfg=NONE ctermbg=NONE gui=reverse guifg=NONE guibg=NONE
hi TabLineSel term=reverse cterm=reverse ctermfg=NONE ctermbg=NONE gui=reverse guifg=NONE guibg=NONE
hi Visual term=reverse cterm=reverse ctermfg=NONE ctermbg=NONE gui=reverse guifg=NONE guibg=NONE
hi VisualNOS term=reverse,underline cterm=reverse,underline ctermfg=NONE ctermbg=NONE gui=reverse,underline guifg=NONE guibg=NONE

" Diff
hi DiffAdd term=NONE cterm=NONE ctermfg=2 ctermbg=NONE gui=NONE guifg=#008000 guibg=NONE
hi DiffChange term=NONE cterm=NONE ctermfg=94 ctermbg=NONE gui=NONE guifg=#875f00 guibg=NONE
hi DiffDelete term=NONE cterm=NONE ctermfg=1 ctermbg=NONE gui=NONE guifg=#800000 guibg=NONE
hi DiffText term=NONE cterm=NONE ctermfg=4 ctermbg=NONE gui=NONE guifg=#000080 guibg=NONE

" Spell
hi SpellBad term=underline cterm=underline ctermfg=5 ctermbg=NONE gui=underline guifg=#CD00CD guibg=NONE
hi SpellCap term=underline cterm=underline ctermfg=5 ctermbg=NONE gui=underline guifg=#CD00CD guibg=NONE
hi SpellLocal term=underline cterm=underline ctermfg=5 ctermbg=NONE gui=underline guifg=#CD00CD guibg=NONE
hi SpellRare term=underline cterm=underline ctermfg=5 ctermbg=NONE gui=underline guifg=#CD00CD guibg=NONE

" Vim Features
hi Menu term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Scrollbar term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi TabLineFill term=NONE cterm=NONE ctermfg=fg ctermbg=248 gui=NONE guifg=fg guibg=#A8A8A8
hi TabLine term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Tooltip term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE

" Syntax Highlighting (or lack there of)
hi Boolean term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Character term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Conceal term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Conditional term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Constant term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Debug term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Define term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Delimiter term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Directive term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Exception term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Float term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Format term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Function term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Identifier term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Ignore term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Include term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Keyword term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Label term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Macro term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Number term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Operator term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi PreCondit term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi PreProc term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Repeat term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi SpecialChar term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi SpecialComment term=NONE cterm=NONE ctermfg=12 ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Special term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Statement term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi StorageClass term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi String term=NONE cterm=NONE ctermfg=2 ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Structure term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Tag term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Title term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Typedef term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Type term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi Underlined term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE

" Sneak
hi SneakLabelMask term=NONE cterm=NONE ctermfg=black ctermbg=195 gui=NONE guifg=black guibg=#d7ffff
hi SneakTarget term=NONE cterm=NONE ctermfg=black ctermbg=195 gui=NONE guifg=black guibg=#d7ffff
hi SneakLabelTarget term=NONE cterm=NONE ctermfg=black ctermbg=183 gui=NONE guifg=black guibg=#d7afff
hi SneakScope term=NONE cterm=NONE ctermfg=black ctermbg=183 gui=NONE guifg=black guibg=#d7afff

" QuickScope
hi QuickScopePrimary term=NONE cterm=underline ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi QuickScopeSecondary term=NONE cterm=underline ctermfg=8 ctermbg=NONE guifg=NONE guibg=NONE

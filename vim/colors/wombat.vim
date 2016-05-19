" Vim color file
" Original Maintainer: Lars H. Nielsen (dengmao@gmail.com)
" Last Change: 2014-07-05
"
" Modified version by
"  Adam Stankiewicz (sheerun@sher.pl)
" Modified version of wombat for 256-color terminals by
"  David Liang (bmdavll@gmail.com)
" based on version by
"  Danila Bespalov (danila.bespalov@gmail.com)

set background=dark

if version > 580
 hi clear
 if exists("syntax_on")
 syntax reset
 endif
endif

let colors_name = "wombat"

" General colors
hi Normal ctermfg=252 ctermbg=234 cterm=none
hi Cursor ctermfg=234 ctermbg=228 cterm=none
hi Visual ctermfg=251 ctermbg=239 cterm=none
hi VisualNOS ctermfg=251 ctermbg=236 cterm=none
hi Search ctermfg=177 ctermbg=241 cterm=none
hi Folded ctermfg=103 ctermbg=237 cterm=none
hi Title ctermfg=230 cterm=bold
hi StatusLine ctermfg=230 ctermbg=238 cterm=none
hi VertSplit ctermfg=238 ctermbg=238 cterm=none
hi StatusLineNC ctermfg=241 ctermbg=238 cterm=none
hi LineNr ctermfg=241 ctermbg=234 cterm=none
hi SpecialKey ctermfg=241 ctermbg=234 cterm=none
hi WarningMsg ctermfg=203
hi ErrorMsg ctermfg=196 ctermbg=234 cterm=bold
hi SpellBad ctermfg=196 ctermbg=234 cterm=bold
hi SpellCap ctermfg=196 ctermbg=234 cterm=bold

" Vim >= 7.0 specific colors
if version >= 700
 hi CursorLine ctermbg=235 cterm=none
 hi CursorColumn ctermbg=235 cterm=none
 hi MatchParen ctermfg=228 ctermbg=101 cterm=bold
 hi Pmenu ctermfg=230 ctermbg=238
 hi PmenuSel ctermfg=232 ctermbg=192
endif

" Diff highlighting
hi DiffAdd ctermbg=17
hi DiffDelete ctermfg=234 ctermbg=60 cterm=none
hi DiffText ctermbg=53 cterm=none
hi DiffChange ctermbg=237

" Syntax highlighting
hi Keyword ctermfg=111 cterm=none
hi Statement ctermfg=111 cterm=none
hi Constant ctermfg=173 cterm=none
hi Number ctermfg=173 cterm=none
hi PreProc ctermfg=173 cterm=none
hi Function ctermfg=192 cterm=none
hi Identifier ctermfg=192 cterm=none
hi Type ctermfg=186 cterm=none
hi Special ctermfg=229 cterm=none
hi String ctermfg=113 cterm=none
hi Comment ctermfg=246 cterm=none
hi Todo ctermbg=108 cterm=none

" Links
hi! link FoldColumn Folded
hi! link CursorColumn CursorLine
hi! link NonText LineNr

set cursorcolumn
set cursorline

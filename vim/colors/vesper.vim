" Vesper - a warm dark colorscheme for Vim
" Based on the Vesper theme by Rauno Freiberg
" Ported to classic Vim by Claude

highlight clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'vesper'
set background=dark

" ── Palette ──────────────────────────────────────────────
" bg:        #101010
" bg_float:  #232323
" bg_visual: #282828
" fg:        #ffffff
" comment:   #696969
" grey:      #8b8b8b
" grey_dk:   #505050
" accent:    #a0a0a0
" orange:    #ffc799
" green:     #99ffe4
" red:       #ff8080
" warn:      #ffcfa8

" ── Editor ───────────────────────────────────────────────
hi Normal          guifg=#ffffff  guibg=#101010  gui=NONE       ctermfg=15    ctermbg=233   cterm=NONE
hi NormalFloat     guifg=#ffffff  guibg=#232323  gui=NONE       ctermfg=15    ctermbg=235   cterm=NONE
hi Cursor          guifg=#101010  guibg=#ffffff  gui=NONE       ctermfg=233   ctermbg=15    cterm=NONE
hi CursorLine      guifg=NONE     guibg=#1a1a1a  gui=NONE       ctermfg=NONE  ctermbg=234   cterm=NONE
hi CursorColumn    guifg=NONE     guibg=#1a1a1a  gui=NONE       ctermfg=NONE  ctermbg=234   cterm=NONE
hi ColorColumn     guifg=NONE     guibg=#1a1a1a  gui=NONE       ctermfg=NONE  ctermbg=234   cterm=NONE
hi LineNr          guifg=#505050  guibg=NONE     gui=NONE       ctermfg=239   ctermbg=NONE  cterm=NONE
hi CursorLineNr    guifg=#a0a0a0  guibg=NONE     gui=NONE       ctermfg=248   ctermbg=NONE  cterm=NONE
hi SignColumn      guifg=NONE     guibg=#101010  gui=NONE       ctermfg=NONE  ctermbg=233   cterm=NONE
hi VertSplit       guifg=#505050  guibg=NONE     gui=NONE       ctermfg=239   ctermbg=NONE  cterm=NONE
hi StatusLine      guifg=#ffffff  guibg=#232323  gui=NONE       ctermfg=15    ctermbg=235   cterm=NONE
hi StatusLineNC    guifg=#505050  guibg=#1a1a1a  gui=NONE       ctermfg=239   ctermbg=234   cterm=NONE
hi TabLine         guifg=#8b8b8b  guibg=#1a1a1a  gui=NONE       ctermfg=245   ctermbg=234   cterm=NONE
hi TabLineFill     guifg=NONE     guibg=#101010  gui=NONE       ctermfg=NONE  ctermbg=233   cterm=NONE
hi TabLineSel      guifg=#ffffff  guibg=#232323  gui=NONE       ctermfg=15    ctermbg=235   cterm=NONE
hi WildMenu        guifg=#101010  guibg=#ffc799  gui=NONE       ctermfg=233   ctermbg=223   cterm=NONE
hi Folded          guifg=#8b8b8b  guibg=#1a1a1a  gui=NONE       ctermfg=245   ctermbg=234   cterm=NONE
hi FoldColumn      guifg=#505050  guibg=#101010  gui=NONE       ctermfg=239   ctermbg=233   cterm=NONE
hi NonText         guifg=#343434  guibg=NONE     gui=NONE       ctermfg=236   ctermbg=NONE  cterm=NONE
hi SpecialKey      guifg=#343434  guibg=NONE     gui=NONE       ctermfg=236   ctermbg=NONE  cterm=NONE
hi EndOfBuffer     guifg=#101010  guibg=NONE     gui=NONE       ctermfg=233   ctermbg=NONE  cterm=NONE

" ── Search & Selection ───────────────────────────────────
hi Visual          guifg=NONE     guibg=#282828  gui=NONE       ctermfg=NONE  ctermbg=236   cterm=NONE
hi VisualNOS       guifg=NONE     guibg=#282828  gui=NONE       ctermfg=NONE  ctermbg=236   cterm=NONE
hi Search          guifg=#101010  guibg=#ffc799  gui=NONE       ctermfg=233   ctermbg=223   cterm=NONE
hi IncSearch       guifg=#101010  guibg=#99ffe4  gui=NONE       ctermfg=233   ctermbg=158   cterm=NONE
hi MatchParen      guifg=#ffc799  guibg=NONE     gui=bold       ctermfg=223   ctermbg=NONE  cterm=bold

" ── Popup Menu ───────────────────────────────────────────
hi Pmenu           guifg=#ffffff  guibg=#232323  gui=NONE       ctermfg=15    ctermbg=235   cterm=NONE
hi PmenuSel        guifg=#ffffff  guibg=#343434  gui=NONE       ctermfg=15    ctermbg=236   cterm=NONE
hi PmenuSbar       guifg=NONE     guibg=#282828  gui=NONE       ctermfg=NONE  ctermbg=236   cterm=NONE
hi PmenuThumb      guifg=NONE     guibg=#505050  gui=NONE       ctermfg=NONE  ctermbg=239   cterm=NONE

" ── Messages & Diagnostics ───────────────────────────────
hi ErrorMsg        guifg=#ff8080  guibg=NONE     gui=NONE       ctermfg=210   ctermbg=NONE  cterm=NONE
hi WarningMsg      guifg=#ffcfa8  guibg=NONE     gui=NONE       ctermfg=223   ctermbg=NONE  cterm=NONE
hi MoreMsg         guifg=#99ffe4  guibg=NONE     gui=NONE       ctermfg=158   ctermbg=NONE  cterm=NONE
hi Question        guifg=#99ffe4  guibg=NONE     gui=NONE       ctermfg=158   ctermbg=NONE  cterm=NONE
hi Title           guifg=#ffc799  guibg=NONE     gui=bold       ctermfg=223   ctermbg=NONE  cterm=bold
hi Directory       guifg=#ffc799  guibg=NONE     gui=NONE       ctermfg=223   ctermbg=NONE  cterm=NONE

" ── Diff ─────────────────────────────────────────────────
hi DiffAdd         guifg=NONE     guibg=#1a2e2a  gui=NONE       ctermfg=NONE  ctermbg=23    cterm=NONE
hi DiffChange      guifg=NONE     guibg=#2a2518  gui=NONE       ctermfg=NONE  ctermbg=58    cterm=NONE
hi DiffDelete      guifg=#ff8080  guibg=#2a1515  gui=NONE       ctermfg=210   ctermbg=52    cterm=NONE
hi DiffText        guifg=NONE     guibg=#3a3020  gui=NONE       ctermfg=NONE  ctermbg=94    cterm=NONE

" ── Spell ────────────────────────────────────────────────
hi SpellBad        guifg=NONE     guibg=NONE     gui=undercurl  guisp=#ff8080  ctermfg=210  ctermbg=NONE  cterm=underline
hi SpellCap        guifg=NONE     guibg=NONE     gui=undercurl  guisp=#ffc799  ctermfg=223  ctermbg=NONE  cterm=underline
hi SpellRare       guifg=NONE     guibg=NONE     gui=undercurl  guisp=#99ffe4  ctermfg=158  ctermbg=NONE  cterm=underline
hi SpellLocal      guifg=NONE     guibg=NONE     gui=undercurl  guisp=#a0a0a0  ctermfg=248  ctermbg=NONE  cterm=underline

" ── Syntax ───────────────────────────────────────────────
hi Comment         guifg=#696969  guibg=NONE     gui=italic     ctermfg=242   ctermbg=NONE  cterm=italic

hi Constant        guifg=#ffc799  guibg=NONE     gui=NONE       ctermfg=223   ctermbg=NONE  cterm=NONE
hi String          guifg=#99ffe4  guibg=NONE     gui=NONE       ctermfg=158   ctermbg=NONE  cterm=NONE
hi Character       guifg=#99ffe4  guibg=NONE     gui=NONE       ctermfg=158   ctermbg=NONE  cterm=NONE
hi Number          guifg=#ffc799  guibg=NONE     gui=NONE       ctermfg=223   ctermbg=NONE  cterm=NONE
hi Boolean         guifg=#ffc799  guibg=NONE     gui=NONE       ctermfg=223   ctermbg=NONE  cterm=NONE
hi Float           guifg=#ffc799  guibg=NONE     gui=NONE       ctermfg=223   ctermbg=NONE  cterm=NONE

hi Identifier      guifg=#ffffff  guibg=NONE     gui=NONE       ctermfg=15    ctermbg=NONE  cterm=NONE
hi Function        guifg=#ffc799  guibg=NONE     gui=NONE       ctermfg=223   ctermbg=NONE  cterm=NONE

hi Statement       guifg=#a0a0a0  guibg=NONE     gui=NONE       ctermfg=248   ctermbg=NONE  cterm=NONE
hi Conditional     guifg=#a0a0a0  guibg=NONE     gui=NONE       ctermfg=248   ctermbg=NONE  cterm=NONE
hi Repeat          guifg=#a0a0a0  guibg=NONE     gui=NONE       ctermfg=248   ctermbg=NONE  cterm=NONE
hi Label           guifg=#a0a0a0  guibg=NONE     gui=NONE       ctermfg=248   ctermbg=NONE  cterm=NONE
hi Operator        guifg=#a0a0a0  guibg=NONE     gui=NONE       ctermfg=248   ctermbg=NONE  cterm=NONE
hi Keyword         guifg=#a0a0a0  guibg=NONE     gui=NONE       ctermfg=248   ctermbg=NONE  cterm=NONE
hi Exception       guifg=#a0a0a0  guibg=NONE     gui=NONE       ctermfg=248   ctermbg=NONE  cterm=NONE

hi PreProc         guifg=#a0a0a0  guibg=NONE     gui=NONE       ctermfg=248   ctermbg=NONE  cterm=NONE
hi Include         guifg=#a0a0a0  guibg=NONE     gui=NONE       ctermfg=248   ctermbg=NONE  cterm=NONE
hi Define          guifg=#a0a0a0  guibg=NONE     gui=NONE       ctermfg=248   ctermbg=NONE  cterm=NONE
hi Macro           guifg=#a0a0a0  guibg=NONE     gui=NONE       ctermfg=248   ctermbg=NONE  cterm=NONE
hi PreCondit       guifg=#a0a0a0  guibg=NONE     gui=NONE       ctermfg=248   ctermbg=NONE  cterm=NONE

hi Type            guifg=#ffc799  guibg=NONE     gui=NONE       ctermfg=223   ctermbg=NONE  cterm=NONE
hi StorageClass    guifg=#a0a0a0  guibg=NONE     gui=NONE       ctermfg=248   ctermbg=NONE  cterm=NONE
hi Structure       guifg=#ffc799  guibg=NONE     gui=NONE       ctermfg=223   ctermbg=NONE  cterm=NONE
hi Typedef         guifg=#ffc799  guibg=NONE     gui=NONE       ctermfg=223   ctermbg=NONE  cterm=NONE

hi Special         guifg=#ffc799  guibg=NONE     gui=NONE       ctermfg=223   ctermbg=NONE  cterm=NONE
hi SpecialChar     guifg=#ffc799  guibg=NONE     gui=NONE       ctermfg=223   ctermbg=NONE  cterm=NONE
hi Tag             guifg=#ffc799  guibg=NONE     gui=NONE       ctermfg=223   ctermbg=NONE  cterm=NONE
hi Delimiter       guifg=#a0a0a0  guibg=NONE     gui=NONE       ctermfg=248   ctermbg=NONE  cterm=NONE
hi SpecialComment  guifg=#8b8b8b  guibg=NONE     gui=italic     ctermfg=245   ctermbg=NONE  cterm=italic
hi Debug           guifg=#ff8080  guibg=NONE     gui=NONE       ctermfg=210   ctermbg=NONE  cterm=NONE

hi Underlined      guifg=NONE     guibg=NONE     gui=underline  ctermfg=NONE  ctermbg=NONE  cterm=underline
hi Ignore          guifg=NONE     guibg=NONE     gui=NONE       ctermfg=NONE  ctermbg=NONE  cterm=NONE
hi Error           guifg=#ff8080  guibg=NONE     gui=NONE       ctermfg=210   ctermbg=NONE  cterm=NONE
hi Todo            guifg=#ffc799  guibg=NONE     gui=bold       ctermfg=223   ctermbg=NONE  cterm=bold

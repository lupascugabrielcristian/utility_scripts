" Asta este o schema alba customizata de mine
" Am pus-o la ~/.config/nvim/colors/zellner2.vim
" Am setat cu :colorscheme zellner2
"
" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file

set background=light
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "zellner22"

" Comments
hi Comment term=bold ctermfg=Red guifg=#9A9A9A
hi Normal guifg=#2F001B guibg=#FCFAED
hi Constant term=underline ctermfg=Magenta guifg=#009E5B
hi Special term=bold ctermfg=Magenta guifg=#8800DF
hi Identifier term=underline ctermfg=Blue guifg=#0B39F2
"return
hi Statement term=bold ctermfg=DarkRed gui=NONE guifg=Brown 
" def, end, require
hi PreProc term=underline ctermfg=Magenta guifg=#7500A5
hi Type term=underline ctermfg=Blue gui=NONE guifg=Blue
hi Visual term=reverse ctermfg=Yellow ctermbg=Red gui=NONE guifg=Black guibg=Yellow
hi Search term=reverse ctermfg=Black ctermbg=Cyan gui=NONE guifg=Black guibg=#21FFBF
hi Tag term=bold ctermfg=DarkGreen guifg=DarkGreen
hi Error term=reverse ctermfg=15 ctermbg=9 guibg=Red guifg=White
hi Todo term=standout ctermbg=Yellow ctermfg=Black guifg=Blue guibg=Yellow
"era DarkGray
hi StatusLine term=bold,reverse cterm=NONE ctermfg=Yellow ctermbg=DarkGray gui=NONE guifg=Yellow guibg=#204CA0 
hi CursorLine guibg=#FDF3B4
hi! link MoreMsg Comment
hi! link ErrorMsg Visual
hi! link WarningMsg ErrorMsg
hi! link Question Comment
hi link String	Constant
hi link Character	Constant
hi link Number	Constant
hi link Boolean	Constant
hi link Float		Number
hi link Function	Identifier
hi link Conditional	Statement
hi link Repeat	Statement
hi link Label		Statement
hi link Operator	Statement
hi link Keyword	Statement
hi link Exception	Statement
hi link Include	PreProc
hi link Define	PreProc
hi link Macro		PreProc
hi link PreCondit	PreProc
hi link StorageClass	Type
hi link Structure	Type
hi link Typedef	Type
hi link SpecialChar	Special
hi link Delimiter	Special
hi link SpecialComment Special
hi link Debug		Special


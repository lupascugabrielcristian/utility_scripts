" Vim color file
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2001 Jul 23

" This is the default color scheme.  It doesn't define the Normal
" highlighting, it uses whatever the colors used to be.

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let colors_name = "cristi"

" vim: sw=2

" --------------------------------
" Completion menu
" --------------------------------
hi Pmenu           ctermfg=Gray     ctermbg=Black    cterm=NONE    guifg=#8C8C8C    guibg=#1B1332    gui=NONE
hi PmenuSel        ctermfg=Gray     ctermbg=Black    cterm=NONE    guifg=#7F5CEF    guibg=#B6E817    gui=NONE
hi PmenuSbar       ctermfg=Gray     ctermbg=Black    cterm=NONE    guifg=#8C8C8C    guibg=#0D0D0D    gui=NONE
hi PmenuThumb      ctermfg=Gray     ctermbg=Black    cterm=NONE    guifg=#8C8C8C    guibg=#0D0D0D    gui=NONE


" --------------------------------
" Custom select colors
" --------------------------------
hi Visual term=reverse guibg=#ffa500 guifg=#4b0082


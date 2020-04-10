set nu
set nowrap
set tabstop=4
set shiftwidth=4
set smartindent
set t_Co=256
set termguicolors
set background=dark
set scrolloff=3
"colorscheme kuroi
set rtp+=/home/cristi/Downloads/tabnine-vim
set nocompatible

autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript

" Exit terminal mode with Esc key
tnoremap <Esc> <C-\><C-n>

" Surround word with quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

" Surround selection with < >
vnoremap <leader>< <esc>`<i<<esc>`>ea><esc>
vnoremap <leader>> <esc>`<i<<esc>`>ea><esc>

" Surround selection with ( )
vnoremap <leader>( <esc>`<i(<esc>`>ea)<esc>
vnoremap <leader>) <esc>`<i(<esc>`>ea)<esc>

vnoremap <leader>" <esc>`<i(<esc>`>ea)<esc>

" Adds a semicolon to the end of the line
nnoremap <leader>;; mqA;<esc>`q

" netwr File browser
let g:netrw_banner=0 		" disables banner
let g:netrw_liststyle=3		" tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
""""""""""""""""""""""""""""""""""""""""""""""""""

" For vim wiki "  
call plug#begin()
Plug 'vimwiki/vimwiki'
call plug#end()

filetype plugin on
syntax on
""""""""""""""""""""""""""""""

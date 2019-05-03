set nu
set nowrap
set tabstop=4
set shiftwidth=4
set smartindent
set t_Co=256
set termguicolors
set background=dark
"colorscheme kuroi
set rtp+=/home/cristi/Downloads/tabnine-vim

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

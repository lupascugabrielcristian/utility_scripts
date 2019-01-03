set nu
set nowrap
set tabstop=4
set shiftwidth=4
set smartindent
set rtp+=/home/cristi/Downloads/tabnine-vim

autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript

" Exit terminal mode with Esc key
tnoremap <Esc> <C-\><C-n>

" Sorround word with quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

" Sorround selection with < >
vnoremap <leader>< <esc>`<i<<esc>`>ea><esc>
vnoremap <leader>> <esc>`<i<<esc>`>ea><esc>

" Sorround selection with ( )
vnoremap <leader>( <esc>`<i(<esc>`>ea)<esc>
vnoremap <leader>) <esc>`<i(<esc>`>ea)<esc>

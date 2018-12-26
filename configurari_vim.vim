set nu
set nowrap
set tabstop=4
set shiftwidth=4
set smartindent
set rtp+=/home/cristi/Downloads/tabnine-vim

autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript

"Inserts the text asdfasdfaf at cursor
command CC :normal i asdfasdfaf

" Exit terminal mode with Esc key
tnoremap <Esc> <C-\><C-n>


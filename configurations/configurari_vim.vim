set number relativenumber
set nowrap
set tabstop=4
set shiftwidth=4
set smartindent
set t_Co=256
set termguicolors
set background=dark
set scrolloff=3
" For white colorscheme uncomment this
" colorscheme zellner
set nocompatible
set clipboard=unnamedplus
set cursorline
filetype plugin on
syntax on

autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript

" Exit terminal mode with Esc key
tnoremap <Esc> <C-\><C-n>

" Surround word with quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

" Surround word with *
nnoremap <leader>* viw<esc>a*<esc>bi*<esc>lel

" Surround selection with < >
vnoremap <leader>< <esc>`<i<<esc>`>ea><esc>
vnoremap <leader>> <esc>`<i<<esc>`>ea><esc>

" Surround selection with ( )
vnoremap <leader>( <esc>`<i(<esc>`>ea)<esc>
vnoremap <leader>) <esc>`<i(<esc>`>ea)<esc>

" Yank text inside $. Commands in vimwiki
nnoremap yi$ maF$lyt$`ah 

" Surround selection with "
vnoremap <leader>" <esc>`<i(<esc>`>ea)<esc>

" Adds a semicolon to the end of the line
nnoremap <leader>;; mqA;<esc>`q

function! CopyLineUp(lines_up)
	echo "copy from " .a:lines_up. " lines up"
	execute "normal! 0mq" .a:lines_up. "kyy`qP"
endfunction
command -nargs=1 Clu call CopyLineUp(<args>)
" :Clu 4 has the effect to copy the 4th line up, to current positon

function! CopyLineDown(lines_down)
	echo "copy from " .a:lines_down. " lines down"
	execute "normal! 0mq" .a:lines_down. "jyy`qP"
endfunction
command -nargs=1 Cld call CopyLineDown(<args>)
" :Cld 4 has the effect to copy the 4th line down, to current positon

" Go to the next python function. Finds the next 'def'
function! FindNextDef()
	" Decid cum caut inceputul functiilor functie de extensia fisierului
	let function_begin = ""
	let extension = expand('%:e')

	if extension == "py"
		let function_begin = "def"
	elseif extension == "java"
		let function_begin = "public\\|private\\|protected"
	endif

	" Merg la urmatoarea pozitie a inceputului unei functii
	call search(function_begin)
	"execute("/".function_begin)

	" Intru la prima linie a functiei
	" PYTHON
	if extension == "py"
		call cursor( line('.') + 1, col('.') + 4 )

		" Pentru fisierele python, vreau sa trec peste comentarii
		" Iau caracterul de sub cursor in pozitia curenta
		let cursor_pos = getpos('.')
		let c = getline(line('.'))[cursor_pos[2] - 1]

		" Daca este caracterul ", consider ca este un grup de tipul:
		" """
		" ...
		" """
		" Merg sub linia unde se termina comentariile
		if c == '"' 
			call search('"""')
			call cursor( line('.') + 1, col('.') )
		endif
	" JAVA
	elseif extension == "java"
		echo "Aici e urmatoarea functie"
	endif


	" Centrez ecranul pe verticala
	execute "normal! zz"
	return
endfunction
nnoremap <leader>nd :call FindNextDef()<cr>

" netwr File browser
let g:netrw_banner=0 		" disables banner
let g:netrw_liststyle=3		" tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
""""""""""""""""""""""""""""""""""""""""""""""""""
" For TabNine
" add here the path to the download foleder
" set rtp+=/home/cristi/.local/share/nvim/site/plugin/tabnine/tabnine-vim

""""""""""""""""""""""""""""""""""""""""""""""""""

" For fzf easyer search command
nnoremap <leader>f :FZF<cr>

" For vim wiki "  
call plug#begin()
Plug 'vimwiki/vimwiki'
Plug '~/.fzf'
call plug#end()

""""""""""""""""""""""""""""""

" Denite mappings
autocmd FileType denite call s:denite_my_settings()
	function! s:denite_my_settings() abort
	  nnoremap <silent><buffer><expr> <CR>
	  \ denite#do_map('do_action')
	  nnoremap <silent><buffer><expr> d
	  \ denite#do_map('do_action', 'delete')
	  nnoremap <silent><buffer><expr> p
	  \ denite#do_map('do_action', 'preview')
	  nnoremap <silent><buffer><expr> q
	  \ denite#do_map('quit')
	  nnoremap <silent><buffer><expr> i
	  \ denite#do_map('open_filter_buffer')
	  nnoremap <silent><buffer><expr> <Space>
	  \ denite#do_map('toggle_select').'j'
	  nnoremap <silent><buffer><expr> <Backspace>
	  \ denite#do_map('move_up_path')
	endfunction
nnoremap <leader>D :Denite file/rec <CR> /

""""""""""""""""""""""""""""""

" Wiki 1
let wiki_1 = {}
let wiki_1.path = '~/vimwiki/'
" Wiki 2
let wiki_2 = {}
let wiki_2.path = '~/prolog-vimwiki/'
let g:vimwiki_list = [wiki_1, wiki_2]

" Setez syntaxa de prolog
nnoremap <leader>pl :set syntax=prolog<esc>

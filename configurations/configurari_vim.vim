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
colorscheme zellner2
set nocompatible
set clipboard=unnamedplus
set cursorline
set expandtab
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

" Pentru a vedea syntaxa prolog in vimwiki 2, cel in care tine knowledge base
" pentru prolog
nnoremap <leader>pl :set syntax=prolog<cr>

" Writes nameserver ... and saves
nnoremap <leader>nn inameserver 192.168.1.1<cr>nameserver 86.121.221.240<cr>nameserver 81.196.2.27<cr>nameserver 5.2.219.31<cr>nameserver 5.2.148.118<esc>:w<cr>

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
let g:netrw_browse_split=2  " 0: Re-use same window, 1: Horizontal split, 2: Vertical split, 3: In new tab, 4: In previous window
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

nnoremap <leader>S :VimwikiSearch

let wiki_1 = {}
let wiki_1.path = '~/vimwiki/'
let wiki_1.path_html = '~/vimwiki_html/'

let wiki_2 = {}
let wiki_2.path = '~/prolog-vimwiki/'
let wiki_2.path_html = '~/prolog-vimwiki-html/'

let g:vimwiki_list = [wiki_1, wiki_2]

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


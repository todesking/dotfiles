function! s:add() abort " {{{
    let opts = {}
    exec 'Plugin ''' . s:repo . ''''
    let s:repo = ''
    call s:add_hook()
endfunction " }}}

function! s:add_hook() abort
    if has_key(s:hooks, 'post_source')
        call add(g:plugin_hooks, s:hooks.post_source)
    endif
    let s:hooks = {}
endfunction

let s:repo = ''
let s:hooks = {}

let s:repo = 'Shougo/deoplete.nvim'
function! s:hooks.post_source() abort
    let g:deoplete#enable_at_startup = 1
    augroup vimrc-deoplete
        autocmd!
        autocmd FileType denite-filter call deoplete#custom#buffer_option('auto_complete', v:false)
    augroup END
endfunction
call s:add()

let s:repo = 'cespare/vim-toml'
call s:add()

let s:repo = 'todesking/current_project.vim'
function! s:hooks.post_source() abort " {{{
	" e-in-current-project
	command! -complete=customlist,current_project#complete -nargs=1 Pe :exec ':e ' . current_project#info().path . '/' . "<args>"
	command! -complete=customlist,current_project#complete_main -nargs=1 PE :exec ':e ' . current_project#info().main_path . '/' . "<args>"
endfunction " }}}
call s:add()


let s:repo = 'osyo-manga/vim-brightest'
function! s:hooks.post_source()
endfunction
call s:add()

let s:repo = 'Shougo/denite.nvim' " {{{
function! s:hooks.post_source() abort " {{{
    augroup vimrc-denite
        autocmd!
        autocmd FileType denite call s:denite_my_settings()
		autocmd FileType denite call s:denite_my_syntax()
        autocmd FileType denite-filter call s:denite_filter_my_settings()
	augroup END

    call denite#custom#option('_', 'direction', 'topleft')

    call denite#custom#source(
        \ 'file_rec,file_mru,project_file_mru',
        \ 'converters',
        \ ['converter/project_name', 'converter/mark_dup']
        \ )

    call denite#custom#var(
        \ 'file_rec',
        \ 'command',
        \ [expand('~/.vim/bin/list_file_rec')]
        \ )

    nnoremap <C-Q><C-P> :<C-u>Denite -resume -cursor-pos=-1 -immediately<CR>
    nnoremap <C-Q><C-N> :<C-u>Denite -resume -cursor-pos=+1 -immediately<CR>
endfunction " }}}

function! s:denite_my_settings() abort " {{{
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> <ESC> denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction " }}}
function! s:denite_filter_my_settings() abort " {{{
    imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
    imap <silent><buffer> <ESC> <Plug>(denite_filter_quit)
    imap <silent><buffer><expr> <CR> denite#do_map('do_action')
    imap <silent><buffer><expr> <C-N> denite#do_map('do_action')
    inoremap <silent><buffer> <C-n> <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
    inoremap <silent><buffer> <C-p> <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
endfunction " }}}
function! s:denite_my_syntax() abort " {{{
	syntax region MyDeniteUnimportant matchgroup=MyDeniteConceal excludenl start=/\V{{{/ end=/\V}}}/ concealends
		\ containedin=deniteSource_file_rec,deniteSource_file_mru,deniteSource_project_file_mru
	highlight link MyDeniteUnimportant Comment
	setlocal concealcursor+=i
endfunction " }}}

call s:add() " }}}

let s:repo = 'Shougo/neomru.vim'
function! s:hooks.post_source() abort
    nnoremap <silent> <C-S> :Denite file_mru -start-filter<CR>
endfunction
call s:add()

let s:repo = 'kana/vim-textobj-user'
function! s:hooks.post_source() abort " {{{
	call textobj#user#plugin('lastmofified', {
	\   'lastmodified': {
	\     'select-a': 'al',
	\     'select-a-function': 'g:Vimrc_select_a_last_modified',
	\   },
	\ })
	function! g:Vimrc_select_a_last_modified() abort
		return ['v', getpos("'["), getpos("']")]
	endfunction
endfunction " }}}
cal s:add()

let s:repo = 'kana/vim-operator-user'
call s:add()

let s:repo = 'rhysd/vim-operator-surround'
function! s:hooks.post_source() abort " {{{
	nmap ys <Plug>(operator-surround-append)
	nmap ds <Plug>(operator-surround-delete)
	nmap cs <Plug>(operator-surround-replace)
endfunction " }}}
call s:add()

let s:repo = 'easymotion/vim-easymotion'
function! s:hooks.post_source() abort " {{{
	nmap <silent><C-J> <Plug>(easymotion-w)
	nmap <silent><C-K> <Plug>(easymotion-b)
	vmap <silent><C-J> <Plug>(easymotion-w)
	vmap <silent><C-K> <Plug>(easymotion-b)
	let g:EasyMotion_keys = 'siogkmjferndlhyuxvtcbwa'
endfunction " }}}
call s:add()

let s:repo = 'deris/vim-shot-f'
call s:add()

let s:repo = 'haya14busa/vim-operator-flashy'
function! s:hooks.post_source() abort " {{{
	map y <Plug>(operator-flashy)
	nmap Y <Plug>(operator-flashy)$
endfunction " }}}
call s:add()

let s:repo = 'Shougo/neosnippet.vim'
function! s:hooks.post_source() abort " {{{
	let g:neosnippet#disable_runtime_snippets = {
	\ '_': 1,
	\ }
	imap <C-k>     <Plug>(neosnippet_expand_or_jump)
	let g:neosnippet#snippets_directory='~/.vim/snippets'
endfunction " }}}
call s:add()

let s:repo = 'prabirshrestha/async.vim'
call s:add()

let s:repo = 'prabirshrestha/vim-lsp'
function! s:hooks.post_source() abort " {{{
	augroup vimrc-vim-lsp
		autocmd!
		if executable('clangd')
			au User lsp_setup call lsp#register_server({
				\ 'name': 'clangd',
				\ 'cmd': {server_info->['clangd']},
				\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
				\ })
		endif
		if executable('metals-vim')
			au User lsp_setup call lsp#register_server({
				\ 'name': 'metals',
				\ 'cmd': {server_info->['metals-vim']},
				\ 'initialization_options': { 'rootPatterns': 'build.sbt' },
				\ 'whitelist': ['sbt', 'scala'],
				\ })
		endif
	augroup END
	let g:lsp_signs_enabled = 1         " enable signs
	let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
	let g:lsp_signs_error = {'text': '✗'}
	let g:lsp_signs_warning = {'text': '‼'}
endfunction " }}}
call s:add()

let s:repo = 'itchyny/lightline.vim'
function! s:hooks.post_source() abort " {{{
	function! Vimrc_summarize_project_path(path) abort " {{{
		let path = a:path
		" JVM subproject
		let path = substitute(path, '\v^(.+)\/(src\/%(%(main|test)\/%(java|scala))\/.+)', '[\1] \2', '')
		" JVM package
		let path = substitute(path,
					\ '\v<(src\/%(main|test)\/%(java|scala))\/(.+)/([^/]+)\.%(java|scala)',
					\ '\=submatch(1)."/".substitute(submatch(2),"/",".","g").".".submatch(3)', '')
		" JVM src dir
		let path = substitute(path, '\v<src\/(%(main|test)\/%(java|scala))\/(.+)', '\2(\1)', '')

		return path
	endfunction " }}}
	" let g:lightline {{{
	let g:lightline = {
				\ 'active': {
				\   'left': [['project_component'], ['path_component']],
				\   'right': [['lineinfo'], ['fileformat', 'fileencoding', 'filetype'], ['build_status', 'charinfo'] ],
				\ },
				\ 'inactive': {
				\   'left': [['project_name', 'git_branch'], ['path_component']],
				\   'right': [['lineinfo'], ['fileformat', 'fileencoding', 'filetype'], ['charinfo'] ],
				\ },
				\ 'component': {
				\   'readonly': '%{&readonly?has("gui_running")?"":"ro":""}',
				\   'modified': '%{&modified?"+":""}',
				\   'project_name': '%{current_project#info().name}',
				\   'project_path': '%{Vimrc_summarize_project_path(current_project#file_info(expand(''%''))["file_path"])}',
				\   'charinfo': '%{printf("%6s",GetB())}',
				\ },
				\ 'component_function': {
				\   'git_branch': 'Vimrc_statusline_git_branch',
				\ },
				\ }
	" }}}
	let g:lightline['component']['path_component'] =
				\ g:lightline['component']['project_path'].
				\ g:lightline['component']['readonly'].
				\ g:lightline['component']['modified']
	let g:lightline['component']['project_component'] =
				\ g:lightline['component']['project_name'].
				\ '%{Vimrc_statusline_git_branch()}'
	if has('gui_vimr')
		let g:lightline['separator'] = { 'left': '', 'right': '' }
		let g:lightline['subseparator'] = { 'left': '', 'right': '' }
		let g:lightline['colorscheme'] = 'iceberg'
	endif
	function! Vimrc_statusline_git_branch() abort " {{{
		let throttle_key = 'Vimrc_statusline_git_branch'
		if !throttle#can_enter('b', throttle_key, 3.0)
			return throttle#previous_data('b', throttle_key)
		endif

		if exists('*gitreview#branch_string')
			let s = gitreview#branch_string(expand('%'))
			if len(s)
				let s = '(' . s . ')'
			endif
		else
			let s = ''
		endif
		call throttle#entered('b', throttle_key, s)
		return s
	endfunction " }}}
	function! GetB()
		let c = matchstr(getline('.'), '.', col('.') - 1)
		if &enc != &fenc
			let c = iconv(c, &enc, &fenc)
		endif
		return String2Hex(c)
	endfunction
	" :help eval-examples
	" The function Nr2Hex() returns the Hex string of a number.
	func! Nr2Hex(nr)
		let n = a:nr
		let r = ""
		while n
		let r = '0123456789ABCDEF'[n % 16] . r
		let n = n / 16
		endwhile
		return r
	endfunc
	" The function String2Hex() converts each character in a string to a two
	" character Hex string.
	func! String2Hex(str)
		let out = ''
		let ix = 0
		while ix < strlen(a:str)
		let out = out . Nr2Hex(char2nr(a:str[ix]))
		let ix = ix + 1
		endwhile
		return out
	endfunc
endfunction " }}}
call s:add()


Plugin 'tyrannicaltoucan/vim-deep-space'
Plugin 'altercation/vim-colors-solarized'
Plugin 'sickill/vim-monokai'
Plugin 'cocopon/iceberg.vim'

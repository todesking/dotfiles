scriptencoding utf-8

" Plug: maximbaz/lightline-ale

" Plug: itchyny/lightline.vim {{{
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
	let active_right = [
	\ ['syntax_trace'],
	\ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
	\ ['cocstatus', 'lineinfo'],
	\ ['fileformat', 'fileencoding', 'filetype'], ['build_status', 'charinfo']
	\ ]
	let g:lightline = {
				\ 'active': {
				\   'left': [['project_component'], ['path_component']],
				\   'right': active_right
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
				\   'syntax_trace': '%{get(b:, "lightline_syntax_trace", v:false) ? Vimrc_syntax_trace() : ""}',
				\ },
				\ 'component_function': {
				\   'git_branch': 'Vimrc_statusline_git_branch',
				\   'cocstatus': 'coc#status',
				\ },
				\ }
	" }}}
	let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
	let g:lightline.component_type = {
	  \     'linter_checking': 'left',
	  \     'linter_warnings': 'warning',
	  \     'linter_errors': 'error',
	  \     'linter_ok': 'left',
	  \ }
	let g:lightline['component']['path_component'] =
				\ g:lightline['component']['project_path'].
				\ g:lightline['component']['readonly'].
				\ g:lightline['component']['modified']
	let g:lightline['component']['project_component'] =
				\ g:lightline['component']['project_name'].
				\ '%{Vimrc_statusline_git_branch()}'
	let g:lightline['component']['coc_build_status'] =
				\ '%{coc#status()}'
	if has('gui_vimr')
		let g:lightline['separator'] = { 'left': '', 'right': '' }
		let g:lightline['subseparator'] = { 'left': '', 'right': '' }
		let g:lightline['colorscheme'] = 'ayu_light'
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
	function! GetB() abort
		let c = matchstr(getline('.'), '.', col('.') - 1)
		if &encoding != &fileencoding
			let c = iconv(c, &encoding, &fileencoding)
		endif
		return String2Hex(c)
	endfunction
	" :help eval-examples
	" The function Nr2Hex() returns the Hex string of a number.
	func! Nr2Hex(nr)
		let n = a:nr
		let r = ''
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
" }}}

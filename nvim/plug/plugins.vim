" Plug: Shougo/deoplete.nvim {{{
    let g:deoplete#enable_at_startup = 0
    augroup vimrc-deoplete
        autocmd!
        autocmd FileType denite-filter call deoplete#custom#buffer_option('auto_complete', v:false)
    augroup END
" }}}

" Plug: cespare/vim-toml {{{
" }}}

" Plug: todesking/current_project.vim {{{
	" e-in-current-project
	command! -complete=customlist,current_project#complete -nargs=1 Pe :exec ':e ' . current_project#info().path . '/' . "<args>"
	command! -complete=customlist,current_project#complete_main -nargs=1 PE :exec ':e ' . current_project#info().main_path . '/' . "<args>"
" }}}


" Plug: osyo-manga/vim-brightest {{{
" }}}

" Plug: Shougo/denite.nvim {{{
    augroup vimrc-denite
        autocmd!
        autocmd FileType denite call s:denite_my_settings()
        autocmd FileType denite-filter call s:denite_filter_my_settings()
	augroup END

    call denite#custom#option('_', 'direction', 'topleft')

    call denite#custom#source(
        \ 'file/rec,file_mru,project_file_mru',
        \ 'converters',
        \ ['converter/project_name', 'converter/mark_dup']
        \ )
	call denite#custom#source(
		\ 'file_rec,file/rec,file_mru,file/mru,project_file_mru,unite,tag',
		\ 'matchers',
		\ ['matcher/substring']
		\ )

    call denite#custom#var(
        \ 'file/rec',
        \ 'command',
        \ [expand('~/.vim/bin/list_file_rec')]
        \ )
	" keys {{{
	nnoremap <silent><C-Q>  <ESC>
	nnoremap <silent><C-S> :<C-u>call Vimrc_denite_mru_if_available()<CR>
	nnoremap <silent><C-Q>s :<C-u>Denite file_mru -start-filter<CR>
	nnoremap <silent><C-Q>P :<C-u>exec 'Denite file/rec:' . current_project#info(expand('%')).main_path . ' -start-filter'<CR>
	nnoremap <silent><C-Q>p :<C-u>exec 'Denite file/rec:' . current_project#info(expand('%')).sub_path . ' -start-filter'<CR>
	nnoremap <silent><C-Q>b :<C-u>Denite buffer<CR>
	nnoremap <silent><C-Q>c :<C-u>exec 'Denite file/rec:'.expand('%:p:h').'/'<CR>
	nnoremap <silent><C-Q>o :<C-u>Denite unite:outline -start-filter<CR>
	nnoremap <silent><C-Q>d :<C-u>Denite coc-diagnostic<CR>

	nnoremap <silent><C-Q>u :Denite -resume<CR>
	nnoremap <silent><C-Q><C-P> :<C-u>Denite -resume -cursor-pos=-1 -immediately<CR>
	nnoremap <silent><C-Q><C-N> :<C-u>Denite -resume -cursor-pos=+1 -immediately<CR>
	" }}}

	function! s:denite_my_settings() abort " {{{
	  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
	  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
	  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
	  nnoremap <silent><buffer><expr> q denite#do_map('quit')
	  nnoremap <silent><buffer><expr> <ESC> denite#do_map('quit')
	  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
	  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
	  BrightestLock
	endfunction " }}}
	function! s:denite_filter_my_settings() abort " {{{
		imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
		imap <silent><buffer> <ESC> <Plug>(denite_filter_quit)
		imap <silent><buffer><expr> <CR> denite#do_map('do_action')
		imap <silent><buffer><expr> <C-N> denite#do_map('do_action')
		inoremap <silent><buffer> <C-n> <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
		inoremap <silent><buffer> <C-p> <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
		BrightestLock
	endfunction " }}}
	function! Vimrc_denite_mru_if_available() abort " {{{
		let info = current_project#info()
		if empty(info.name)
			Denite file_mru -start-filter
		else
			exec 'Denite project_file_mru:' . info.path . ' -start-filter'
		endif
	endfunction " }}}
" }}}

" Plug: chemzqm/unite-location {{{
" }}}

" Plug: Shougo/unite.vim {{{
" }}}

" Plug: Shougo/neomru.vim {{{
	let g:neomru#directory_mru_ignore_pattern = g:neomru#directory_mru_ignore_pattern . '\|\%(.metals\)' 
" }}}

" Plug: Shougo/unite-outline {{{
	let g:unite_source_outline_scala_show_all_declarations = 1
	let g:unite_source_outline_max_headings = 10000
	let g:unite_source_outline_cache_limit = 10000
" }}}

" Plug: kana/vim-textobj-user {{{
	call textobj#user#plugin('lastmofified', {
	\   'lastmodified': {
	\     'select-a': 'al',
	\     'select-a-function': 'g:Vimrc_select_a_last_modified',
	\   },
	\ })
	function! g:Vimrc_select_a_last_modified() abort
		return ['v', getpos("'["), getpos("']")]
	endfunction
" }}}

" Plug: kana/vim-operator-user {{{
" }}}

" Plug: rhysd/vim-operator-surround {{{
	nmap ys <Plug>(operator-surround-append)
	nmap ds <Plug>(operator-surround-delete)
	nmap cs <Plug>(operator-surround-replace)
" }}}

" Plug: easymotion/vim-easymotion {{{
	nmap <silent><C-J> <Plug>(easymotion-w)
	nmap <silent><C-K> <Plug>(easymotion-b)
	vmap <silent><C-J> <Plug>(easymotion-w)
	vmap <silent><C-K> <Plug>(easymotion-b)
	let g:EasyMotion_keys = 'siogkmjferndlhyuxvtcbwa'
" }}}

" Plug: deris/vim-shot-f {{{
" }}}

" Plug: haya14busa/vim-operator-flashy {{{
	map y <Plug>(operator-flashy)
	nmap Y <Plug>(operator-flashy)$
" }}}

" Plug: LeafCage/yankround.vim {{{
	nmap p <Plug>(yankround-p)
	xmap p <Plug>(yankround-p)
	nmap P <Plug>(yankround-P)
	nmap gp <Plug>(yankround-gp)
	xmap gp <Plug>(yankround-gp)
	nmap gP <Plug>(yankround-gP)
	nmap <C-p> <Plug>(yankround-prev)
	nmap <C-n> <Plug>(yankround-next)
" }}}

" Plug: Shougo/neosnippet.vim {{{
	let g:neosnippet#disable_runtime_snippets = {
	\ '_': 1,
	\ }
	imap <C-k>     <Plug>(neosnippet_expand_or_jump)
	let g:neosnippet#snippets_directory='~/.vim/snippets'
" }}}

" Plug: prabirshrestha/async.vim {{{
" }}}

" Plug: tyru/caw.vim {{{
" }}}

if 0
" Plug: prabirshrestha/vim-lsp {{{
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
" }}}
endif

" Plug: neoclide/coc.nvim {{{
	nnoremap <silent> gd :<C-u>exec "normal \<Plug>(coc-definition)"<CR>
	nnoremap <silent> gr :<C-u>exec "normal \<Plug>(coc-references)"<CR>
	nnoremap <silent> gh :<C-u>call CocAction('doHover')<CR>
	nnoremap <silent><expr> ,d <SID>coc_toggle_diagnostic()
	inoremap <silent><expr> <Tab>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<Tab>" :
		\ coc#refresh()
	inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
	hi link CocErrorVirtualText Error
	hi link CocWarnVirtualText Comment
	let g:coc_enable_locationlist = 0
	augroup Vimrc_coc
		autocmd!
		autocmd User CocLocationsChange Denite coc-jump-locations
	augroup END
	function! s:check_back_space() abort
	  let col = col('.') - 1
	  return !col || getline('.')[col - 1]  =~# '\s'
	endfunction
	function! s:coc_toggle_diagnostic() abort " {{{
		let k = 'diagnostic.messageTarget'
		let x = has_key(g:coc_user_config, k) ? g:coc_user_config[k] : 'float'
		let y = x ==# 'float' ? 'echo' : 'float'
		call coc#config(k, y)
		doautocmd InsertEnter
		doautocmd InsertLeave
		doautocmd CursorMoved
		echo 'diagnostic: ' . y
	endfunction " }}}
" }}}

" Plug: neoclide/coc-denite {{{
" }}}


" Plug: w0rp/ale {{{
	let g:ale_lint_on_text_changed = v:false
	let g:ale_lint_on_insert_leave = v:false
" }}}

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
	let g:lightline = {
				\ 'active': {
				\   'left': [['project_component'], ['path_component']],
				\   'right': [['cocstatus', 'lineinfo'], ['fileformat', 'fileencoding', 'filetype'], ['build_status', 'charinfo'] ],
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
				\   'cocstatus': 'coc#status',
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
	let g:lightline['component']['coc_build_status'] =
				\ '%{coc#status()}'
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
" }}}

" Plug: tyru/capture.vim {{{
" }}}

" Plug: derekwyatt/vim-scala {{{
" }}}

" Plug: cocopon/iceberg.vim {{{
" }}}

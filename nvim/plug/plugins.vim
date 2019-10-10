scriptencoding utf-8

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

" Plug: w0rp/ale {{{
	let g:ale_lint_on_text_changed = v:false
	let g:ale_lint_on_insert_leave = v:false
" }}}

" Plug: tyru/capture.vim {{{
" }}}

" Plug: derekwyatt/vim-scala {{{
" }}}

" Plug: cocopon/iceberg.vim {{{
" }}}

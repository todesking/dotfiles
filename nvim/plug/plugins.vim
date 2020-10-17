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
	let g:neosnippet#snippets_directory='~/.config/nvim/snippets'
" }}}

" Plug: prabirshrestha/async.vim {{{
" }}}

" Plug: tyru/caw.vim {{{
" }}}

" Plug: w0rp/ale {{{
	let g:ale_enabled = v:false
	let g:ale_lint_on_text_changed = v:false
	let g:ale_lint_on_insert_leave = v:false
	let g:ale_disable_lsp = v:true
	let g:ale_linters_ignore = {'cpp': 
	  \ ['ccls', 'clang', 'clangcheck', 'clangd', 'clangtidy', 'clazy', 'cppcheck', 'cpplint', 'cquery', 'flawfinder', 'gcc']
	  \}
" }}}

" Plug: tyru/capture.vim {{{
" }}}

" Plug: derekwyatt/vim-scala {{{
" }}}

" Plug: cocopon/iceberg.vim {{{
" }}}

" Plug: kchmck/vim-coffee-script {{{
" }}}

" Plug: AndrewRadev/linediff.vim {{{
" }}}

" Plug: airblade/vim-gitgutter {{{
" }}}

" Plug: tpope/vim-fugitive {{{
" }}}

" " Plug: yuezk/vim-js
" Plug: HerringtonDarkholme/yats.vim
" " Plug: MaxMEllon/vim-jsx-pretty

" Plug: mattn/emmet-vim {{{
  let g:user_emmet_mode = 'i'
" }}}

" Plug: vim-scripts/closetag.vim {{{
	augroup vimrc-closetag-vim
		autocmd!
		autocmd Filetype * call Vimrc_ft_closetag()
	augroup END
	function! Vimrc_ft_closetag() abort " {{{
		if &filetype ==# 'xml'
			let b:unaryTagsStack = ''
		else
			let b:unaryTagsStack='area base br dd dt hr img input link meta param'
		endif
	endfunction " }}}
" }}}

" Plug: neoclide/jsonc.vim

" Plug: neoclide/coc.nvim {{{
	let g:coc_global_extensions = [
	  \ 'coc-metals',
	  \ 'coc-json',
	  \ 'coc-tsserver',
	  \ 'coc-tslint-plugin',
	  \ 'coc-html',
	  \ 'coc-css',
	  \ 'coc-prettier'
	\]
	nnoremap <silent> gd :<C-u>exec "normal \<Plug>(coc-definition)"<CR>
	nnoremap <silent> gD :<C-u>exec "normal \<Plug>(coc-declaration)"<CR>
	nnoremap <silent> gr :<C-u>exec "normal \<Plug>(coc-references)"<CR>
	nnoremap <silent> gh :<C-u>call CocAction('doHover')<CR>
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
	nnoremap <silent> ,d :<C-u>call <SID>coc_toggle_diagnostic()<CR>

	function! s:check_back_space() abort
	  let col = col('.') - 1
	  return !col || getline('.')[col - 1]  =~# '\s'
	endfunction
	inoremap <silent><expr> <Tab>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<Tab>" :
		\ coc#refresh()
	inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

	command! -nargs=0 CocFormat :call CocAction('format')

	hi link CocErrorVirtualText Comment
	hi link CocWarningVirtualText Comment
	hi link CocErrorFloat CocInfoFloat
	hi link CocErrorSign CocInfoSign
	hi CocErrorHighlight guifg=#cc77aa

	let g:coc_enable_locationlist = 0
	augroup Vimrc_coc
		autocmd!
		autocmd User CocLocationsChange Denite coc-jump-locations
		autocmd FileType scala let b:coc_root_patterns = ['build.sbt']
	augroup END
" }}}

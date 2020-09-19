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
	nnoremap <silent><C-Q>c :<C-u>exec 'Denite file/rec:'.expand('%:p:h').'/ -start-filter'<CR>
	nnoremap <silent><C-Q>o :<C-u>Denite unite:outline -start-filter<CR>
	nnoremap <silent><C-Q>d :<C-u>Denite coc-diagnostic ale<CR>
	nnoremap <silent><C-Q>t :<C-u>Denite coc-symbols -start-filter<CR>
	nnoremap <silent><C-Q>l :<C-u>Denite -auto-action=preview location_list<CR>

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

" Plug: neoclide/coc-denite {{{
" }}}

" Plug: iyuuya/denite-ale {{{
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

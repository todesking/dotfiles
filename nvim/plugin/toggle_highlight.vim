" Toggle HLS {{{
nnoremap <silent>_ :<C-u>call Vimrc_toggle_highlight()<CR>
function! Vimrc_toggle_highlight() abort " {{{
	" b,h
	let transition = {
	\ '00': [1, 1],
	\ '01': [1, 0],
	\ '10': [0, 0],
	\ '11': [1, 0],
	\ }
	let brightest = g:brightest_enable && get(b:, 'brightest_enable', 1)
	let hlsearch = !!&hlsearch
	let current_state = string(brightest) . string(hlsearch)
	let [b, h] = transition[current_state]
	if b
		BrightestEnable
	else
		BrightestDisable
	endif
	if h
		set hlsearch
	else
		set nohlsearch
	endif
endfunction " }}}
" }}}


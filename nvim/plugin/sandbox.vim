" Sandbox {{{
function! s:register_sandbox(path) abort " {{{
	let files = glob(a:path . '/*', 1, 1)
	for f in files
		" TODO: check rtp
		if isdirectory(f)
			execute 'set runtimepath+=' . fnamemodify(f, ':p')
		endif
	endfor
endfunction " }}}

call s:register_sandbox(expand('~/.config/nvim/sandbox'))
" }}}

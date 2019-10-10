function! g:Vimrc_complete_dir(prefix, ArgLead, CmdLine, CursorPos) abort " {{{
	let prefix = a:prefix . '/'
	let candidates = glob(prefix.a:ArgLead.'*', 1, 1)
	let result = []
	for c in candidates
		if isdirectory(c)
			call add(result, substitute(c, prefix, '', '').'/')
		else
			call add(result, substitute(c, prefix, '', ''))
		endif
	endfor
	return result
endfunction  " }}}

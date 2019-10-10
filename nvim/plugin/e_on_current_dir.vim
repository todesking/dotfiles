" Ce command(e based on Currend dir) {{{
command! -complete=customlist,Vimrc_complete_current_dir -nargs=1 Ce :exec ':e '.expand('%:p:h').'/'."<args>"
function! Vimrc_complete_current_dir(ArgLead, CmdLine, CursorPos)
	return Vimrc_complete_dir(expand('%:p:h'), a:ArgLead, a:CmdLine, a:CursorPos)
endfunction
" }}}

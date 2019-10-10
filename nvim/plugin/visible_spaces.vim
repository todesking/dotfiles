scriptencoding utf-8
" Visible spaces {{{
" http://blog.remora.cx/2011/08/display-invisible-characters-on-vim.html
set list
set listchars=tab:»\ ,trail:_,extends:»,precedes:«,nbsp:%

if has('syntax')
	" PODバグ対策
	syn sync fromstart
	function! ActivateInvisibleIndicator()
		syntax match InvisibleJISX0208Space "　" display containedin=ALL
		highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=darkgray gui=underline
	endf
	augroup invisible
		autocmd! invisible
		autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
	augroup END
endif
" }}}

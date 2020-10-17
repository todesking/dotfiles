" Syntax trace {{{
" from http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
command! SyntaxTrace echo Vimrc_syntax_trace()

function! Vimrc_syntax_trace() abort " {{{
  let hi = synIDattr(synID(line("."),col("."),1),"name")
  let trans = synIDattr(synID(line("."),col("."),0),"name")
  let lo = synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")

  return "hi<" . hi . "> trans<" . trans . "> lo<" . lo . ">"
endfunction " }}}
"}}}


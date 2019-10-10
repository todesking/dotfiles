scriptencoding utf-8

" Folding toggle {{{
nnoremap <silent><SPACE> :call <SID>toggle_folding(0)<CR>
nnoremap <silent><S-SPACE> :call <SID>toggle_folding(1)<CR>
function! s:toggle_folding(deep)
	if foldlevel(line('.'))==0
		return
	elseif foldclosed(line('.'))==-1
		if a:deep
			normal! zC
		else
			normal! zc
		endif
	else
		if a:deep
			normal! zO
		else
			normal! zo
		endif
	end
endfunction
" }}}

" Custom fold style {{{
" http://d.hatena.ne.jp/leafcage/20111223/1324705686
" https://github.com/LeafCage/foldCC/blob/master/plugin/foldCC.vim
" folding look
set foldtext=My_foldtext()
function! My_foldtext() " {{{
	"表示するテキストの作成（折り畳みマーカーを除去）
	let line = s:remove_comment_and_fold_marker(v:foldstart)
	let line = substitute(line, "\t", repeat(' ', &tabstop), 'g')

	"切り詰めサイズをウィンドウに合わせる"{{{
	let regardMultibyte =strlen(line) -strdisplaywidth(line)

	let line_width = winwidth(0) - &foldcolumn
	if &number == 1 "行番号表示オンのとき
		let line_width -= max([&numberwidth, len(line('$'))])
	endif

	let footer_length=9
	let alignment = line_width - footer_length - 4 + regardMultibyte
	"15はprintf()で消費する分、4はfolddasesを使うための余白
	"issue:regardMultibyteで足される分が多い （61桁をオーバーして切り詰められてる場合
	"}}}alignment

	let foldlength=v:foldend-v:foldstart+1
	let dots=repeat('.',float2nr(ceil(foldlength/10.0)))

	return printf('%-'.alignment.'.'.alignment.'s %3d ',line.' '.dots,foldlength)
endfunction " }}}
function! s:fold_navi() "{{{
if foldlevel('.')
	let save_csr=winsaveview()
	let parentList=[]

	"カーソル行が折り畳まれているとき"{{{
	let whtrClosed = foldclosed('.')
	if whtrClosed !=-1
	call insert(parentList, s:surgery_line(whtrClosed) )
	if foldlevel('.') == 1
		call winrestview(save_csr)
		return join(parentList,' > ')
	endif

	normal! [z
	if foldclosed('.') ==whtrClosed
		call winrestview(save_csr)
		return join(parentList,' > ')
	endif
	endif"}}}

	"折畳を再帰的に戻れるとき"{{{
	while 1
	normal! [z
	call insert(parentList, s:surgery_line('.') )
	if foldlevel('.') == 1
		break
	endif
	endwhile
	call winrestview(save_csr)
	return join(parentList,' > ')"}}}
endif
endfunction
" }}}

function! s:remove_comment_and_fold_marker(lnum)"{{{
	let line = getline(a:lnum)
	let comment = split(&commentstring, '%s')
	let comment_end =''
	if len(comment) == 0
		return line
	endif
	if len(comment) >1
	let comment_end=comment[1]
	endif
	let foldmarkers = split(&foldmarker, ',')

	return substitute(line,'\V\%('.comment[0].'\)\?\s\*'.foldmarkers[0].'\%(\d\+\)\?\s\*\%('.comment_end.'\)\?', '','')
endfunction"}}}

function! s:surgery_line(lnum)"{{{
	let line = substitute(s:remove_comment_and_fold_marker(a:lnum),'\V\^\s\*\|\s\*\$','','g')
	let regardMultibyte = len(line) - strdisplaywidth(line)
	let alignment = 60 + regardMultibyte
	return line[:alignment]
endfunction"}}}

" }}}

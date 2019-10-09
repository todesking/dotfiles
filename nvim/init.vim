scriptencoding utf-8
" Vundle {{{
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.cache/nvim-vundle/Vundle.vim
call vundle#begin('~/.cache/nvim-vundle/')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

let g:plugin_hooks = []
source ~/.config/nvim/plugins.vim

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

function! s:activate_hooks() abort
	for H in g:plugin_hooks
		call call(H, [])
	endfor
endfunction
call s:activate_hooks()

"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" }}}

" gui
set mouse=

" search
set ignorecase
set smartcase
set incsearch
set inccommand=split
set wrapscan
set showmatch
augroup vimrc-incsearch-highlight
	autocmd!
	autocmd CmdlineEnter /,\? :set hlsearch
	autocmd CmdlineLeave /,\? :set nohlsearch
augroup END
augroup vimrc-full-screen-help " {{{
	autocmd!
	autocmd BufEnter * call Vimrc_full_screen_help()
	autocmd FileType * call Vimrc_full_screen_help()
	function! Vimrc_full_screen_help() abort
		if  &ft =~# '^\(help\|ref-.*\)$' && winnr() == 1 && winnr('$') == 2 && bufname(winbufnr(2)) == ''
			try
				" This will throw E788, cause unknown
				execute "normal \<C-W>o"
			catch
			endtry
		endif
	endfunction
augroup END " }}}


" status
set number
set showtabline=2

" key
set notimeout
set nottimeout

" cmd mode
set wildmode=list:longest
set wildignorecase
set history=500

" ins mode
set completeopt=menuone,preview

set smartindent
set autoindent

set tabstop=4
set shiftwidth=4
set expandtab
set formatoptions-=cro

augroup vimrc-checktime
    au FocusGained * checktime
augroup END

" buffer
set hidden
set directory=$HOME/.vim/swp
set noswapfile

" misc
set helplang=en,ja
set lazyredraw

" keymap
nnoremap <C-B> :<C-U>up<CR>
nnoremap <silent>,n :tabnew<CR>
nnoremap <silent>H :tabprevious<CR>
nnoremap <silent>L :tabnext<CR>
nnoremap <silent><S-D-}> :tabnext<CR>
nnoremap <silent><S-D-{> :tabprevious<CR>
nnoremap <silent>,H :tabmove -1<CR>
nnoremap <silent>,L :tabmove +1<CR>
nnoremap <silent>y= :<C-U>call setreg("*", getreg("0"))<CR>:<C-U>echo "yanked to *: " . getreg("*")[0:30]<CR>
nnoremap <silent>j gj
nnoremap <silent>k gk

imap <D-Space> <Space>
inoremap <C-E> <END>
inoremap <C-A> <HOME>

cnoremap <C-E> <End>
cnoremap <C-A> <Home>

" command
command! Q qa

" S(source %) {{{
command! S call SourceThis()
" }}}

" Ce command(e based on Currend dir) {{{
command! -complete=customlist,Vimrc_complete_current_dir -nargs=1 Ce :exec ':e '.expand('%:p:h').'/'."<args>"
function! Vimrc_complete_current_dir(ArgLead, CmdLine, CursorPos)
	return Vimrc_complete_dir(expand('%:p:h'), a:ArgLead, a:CmdLine, a:CursorPos)
endfunction
" }}}

" @vimlint(EVL103, 1)
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
" @vimlint(EVL103, 0)


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

" Rename file {{{
" http://vim-users.jp/2009/05/hack17/
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))|w
command! -complete=customlist,Vimrc_complete_current_project_files -nargs=1 PRename exec "f " . current_project#info().main_path . "/<args>"|call delete(expand('#'))|w
command! -complete=customlist,Vimrc_complete_current_dir -nargs=1 CRename exec "f ".expand('%:p:h')."/<args>"|call delete(expand('#'))|w
" }}}

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

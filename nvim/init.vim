scriptencoding utf-8

" Plugin {{{
let s:plugin_config_files = glob('~/.config/nvim/plug/*.vim', v:true, v:true)

function! s:load_plugin_config() abort " {{{
	let plugins = []
	for src in s:plugin_config_files
		let lines = readfile(src)
		for l in lines
			let m = matchlist(l, '" Plug: \([^ ]\+\).*')
			if !empty(m)
				call add(plugins, m[1])
			endif
		endfor
	endfor
	for p in plugins
		execute "Plugin '" . p . "'"
	endfor
endfunction " }}}
function! s:plugin_post_source() abort " {{{
	for src in s:plugin_config_files
		execute 'source ' . src
	endfor
endfunction " }}}

" Vundle {{{
filetype off
set runtimepath+=~/.cache/nvim-vundle/Vundle.vim
call vundle#begin('~/.cache/nvim-vundle/')
Plugin 'VundleVim/Vundle.vim'
call s:load_plugin_config()
call vundle#end()
filetype plugin indent on
" }}}

call s:plugin_post_source()
" }}}

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
set shiftwidth=2
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

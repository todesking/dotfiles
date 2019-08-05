function! s:add() abort " {{{
    let opts = {}
    exec 'Plugin ''' . s:repo . ''''
    let s:repo = ''
    call s:add_hook()
endfunction " }}}

function! s:add_hook() abort
    if has_key(s:hooks, 'post_source')
        call add(g:plugin_hooks, s:hooks.post_source)
    endif
    let s:hooks = {}
endfunction

let s:repo = ''
let s:hooks = {}

let s:repo = 'Shougo/deoplete.nvim'
function! s:hooks.post_source() abort
    let g:deoplete#enable_at_startup = 1
    augroup vimrc-deoplete
        autocmd!
        autocmd FileType denite-filter call deoplete#custom#buffer_option('auto_complete', v:false)
    augroup END
endfunction
call s:add()

let s:repo = 'cespare/vim-toml'
call s:add()

let s:repo = 'todesking/current_project.vim'
function! s:hooks.post_source() abort " {{{
	" e-in-current-project
	command! -complete=customlist,current_project#complete -nargs=1 Pe :exec ':e ' . current_project#info().path . '/' . "<args>"
	command! -complete=customlist,current_project#complete_main -nargs=1 PE :exec ':e ' . current_project#info().main_path . '/' . "<args>"
endfunction " }}}
call s:add()


let s:repo = 'osyo-manga/vim-brightest'
function! s:hooks.post_source()
endfunction
call s:add()

let s:repo = 'Shougo/denite.nvim' " {{{
function! s:hooks.post_source() abort " {{{
    augroup vimrc-denite
        autocmd!
        autocmd FileType denite call s:denite_my_settings()
		autocmd FileType denite call s:denite_my_syntax()
        autocmd FileType denite-filter call s:denite_filter_my_settings()
	augroup END

    call denite#custom#option('_', 'direction', 'topleft')

    call denite#custom#source(
        \ 'file_rec,file_mru,project_file_mru',
        \ 'converters',
        \ ['converter/project_name', 'converter/mark_dup']
        \ )

    call denite#custom#var(
        \ 'file_rec',
        \ 'command',
        \ [expand('~/.vim/bin/list_file_rec')]
        \ )

    nnoremap <C-Q><C-P> :<C-u>Denite -resume -cursor-pos=-1 -immediately<CR>
    nnoremap <C-Q><C-N> :<C-u>Denite -resume -cursor-pos=+1 -immediately<CR>
endfunction " }}}

function! s:denite_my_settings() abort " {{{
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> <ESC> denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction " }}}
function! s:denite_filter_my_settings() abort " {{{
    imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
    imap <silent><buffer> <ESC> <Plug>(denite_filter_quit)
    imap <silent><buffer><expr> <CR> denite#do_map('do_action')
    imap <silent><buffer><expr> <C-N> denite#do_map('do_action')
    inoremap <silent><buffer> <C-n> <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
    inoremap <silent><buffer> <C-p> <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
endfunction " }}}
function! s:denite_my_syntax() abort " {{{
	syntax region MyDeniteUnimportant matchgroup=MyDeniteConceal excludenl start=/\V{{{/ end=/\V}}}/ concealends
		\ containedin=deniteSource_file_rec,deniteSource_file_mru,deniteSource_project_file_mru
	highlight link MyDeniteUnimportant Comment
	setlocal concealcursor+=i
endfunction " }}}

call s:add() " }}}

let s:repo = 'Shougo/neomru.vim'
function! s:hooks.post_source() abort
    nnoremap <silent> <C-S> :Denite file_mru -start-filter<CR>
endfunction
call s:add()

let s:repo = 'kana/vim-textobj-user'
function! s:hooks.post_source() abort " {{{
	call textobj#user#plugin('lastmofified', {
	\   'lastmodified': {
	\     'select-a': 'al',
	\     'select-a-function': 'g:Vimrc_select_a_last_modified',
	\   },
	\ })
	function! g:Vimrc_select_a_last_modified() abort
		return ['v', getpos("'["), getpos("']")]
	endfunction
endfunction " }}}
cal s:add()

let s:repo = 'kana/vim-operator-user'
call s:add()

let s:repo = 'rhysd/vim-operator-surround'
function! s:hooks.post_source() abort " {{{
	nmap ys <Plug>(operator-surround-append)
	nmap ds <Plug>(operator-surround-delete)
	nmap cs <Plug>(operator-surround-replace)
endfunction " }}}
call s:add()

let s:repo = 'easymotion/vim-easymotion'
function! s:hooks.post_source() abort " {{{
	nmap <silent><C-J> <Plug>(easymotion-w)
	nmap <silent><C-K> <Plug>(easymotion-b)
	vmap <silent><C-J> <Plug>(easymotion-w)
	vmap <silent><C-K> <Plug>(easymotion-b)
	let g:EasyMotion_keys = 'siogkmjferndlhyuxvtcbwa'
endfunction " }}}
call s:add()

let s:repo = 'deris/vim-shot-f'
call s:add()

let s:repo = 'haya14busa/vim-operator-flashy'
function! s:hooks.post_source() abort " {{{
	map y <Plug>(operator-flashy)
	nmap Y <Plug>(operator-flashy)$
endfunction " }}}
call s:add()

let s:repo = 'Shougo/neosnippet.vim'
function! s:hooks.post_source() abort " {{{
	let g:neosnippet#disable_runtime_snippets = {
	\ '_': 1,
	\ }
	imap <C-k>     <Plug>(neosnippet_expand_or_jump)
	let g:neosnippet#snippets_directory='~/.vim/snippets'
endfunction " }}}
call s:add()

let s:repo = 'prabirshrestha/async.vim'
call s:add()

let s:repo = 'prabirshrestha/vim-lsp'
function! s:hooks.post_source() abort " {{{
	augroup vimrc-vim-lsp
		autocmd!
		if executable('clangd')
			au User lsp_setup call lsp#register_server({
				\ 'name': 'clangd',
				\ 'cmd': {server_info->['clangd']},
				\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
				\ })
		endif
		if executable('metals-vim')
			au User lsp_setup call lsp#register_server({
				\ 'name': 'metals',
				\ 'cmd': {server_info->['metals-vim']},
				\ 'initialization_options': { 'rootPatterns': 'build.sbt' },
				\ 'whitelist': ['sbt', 'scala'],
				\ })
		endif
	augroup END
	let g:lsp_signs_enabled = 1         " enable signs
	let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
	let g:lsp_signs_error = {'text': '✗'}
	let g:lsp_signs_warning = {'text': '‼'}
endfunction " }}}
call s:add()


Plugin 'thinkpixellab/flatland', {'rtp': 'Vim'}
Plugin 'cocopon/iceberg.vim'

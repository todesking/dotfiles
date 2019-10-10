" Rename file {{{
" http://vim-users.jp/2009/05/hack17/
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))|w
command! -complete=customlist,Vimrc_complete_current_project_files -nargs=1 PRename exec "f " . current_project#info().main_path . "/<args>"|call delete(expand('#'))|w
command! -complete=customlist,Vimrc_complete_current_dir -nargs=1 CRename exec "f ".expand('%:p:h')."/<args>"|call delete(expand('#'))|w
" }}}

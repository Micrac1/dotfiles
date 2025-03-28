if exists('g:loaded_dbrowser') || &cp || v:version < 700 || &cpo =~# 'C'
  finish
endif
let g:loaded_dbrowser = 1

" Commands {{{
command! -nargs=? -complete=dir -bang DBrowserOpen call dbrowser#open(<q-args>)
command! -nargs=? -complete=dir -bang DBrowserOpenNoSync call dbrowser#open_no_sync(<q-args>)
"}}}

" Mappings {{{
nnoremap <Plug>(DBrowserOpenAbsolute)   :<C-U>call dbrowser#open('', v:false, v:false)<CR>
nnoremap <Plug>(DBrowserOpen)           :<C-U>call dbrowser#open('', v:false, v:true)<CR>
nnoremap <Plug>(DBrowserNodeExpand)     :<C-U>call dbrowser#node_expand()<CR>
nnoremap <Plug>(DBrowserNodeShrink)     :<C-U>call dbrowser#node_shrink()<CR>
nnoremap <Plug>(DBrowserNodeToggle)     :<C-U>call dbrowser#node_toggle()<CR>
nnoremap <Plug>(DBrowserModeRelative)   :<C-U>call dbrowser#mode_set(1)<CR>
nnoremap <Plug>(DBrowserModeAbsolute)   :<C-U>call dbrowser#mode_set(2)<CR>
nnoremap <Plug>(DBrowserModeToggle)     :<C-U>call dbrowser#mode_set()<CR>
nnoremap <Plug>(DBrowserEnterDir)       :<C-U>call dbrowser#enter_dir()<CR>
nnoremap <Plug>(DBrowserEnterFile)      :<C-U>call dbrowser#enter_file()<CR>
nnoremap <Plug>(DBrowserEnterDirOrFile) :<C-U>call dbrowser#enter_dir_or_file()<CR>
nnoremap <Plug>(DBrowserEnterParent)    :<C-U>call dbrowser#enter_parent()<CR>
nnoremap <Plug>(DBrowserRefresh)        :<C-U>call dbrowser#refresh()<CR>
"}}}

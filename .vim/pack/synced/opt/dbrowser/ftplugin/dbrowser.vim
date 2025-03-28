if exists("b:did_ftplugin")
  finish
endif

" setl isfname+=32
setl cursorline

if (has('conceal') && get(g:, 'dbrowser_conceal', 1))
  setl cocu=nvic
  setl cole=2
endif

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '|'
else
  let b:undo_ftplugin = ''
endif

let map_mode = get(g:, 'dbrowser_mappings', 1)

if (map_mode == 1) " Default mappings
  nmap <buffer> h <Plug>(DBrowserNodeShrink)
  nmap <buffer> l <Plug>(DBrowserNodeExpand)
  nmap <buffer> i <Plug>(DBrowserEnterDir)
  nmap <buffer> - <Plug>(DBrowserEnterParent)
  nmap <buffer> R <Plug>(DBrowserRefresh)

  nmap <buffer> u <Plug>(DBrowserModeToggle)
  nmap <buffer> C :<C-U>DBrowserConcealToggle<CR>

  nmap <buffer> zo <Plug>(DBrowserNodeExpand)
  nmap <buffer> zc <Plug>(DBrowserNodeShrink)

  nmap <buffer> o <Plug>(DBrowserEnterFile)
  nmap <buffer> t <Plug>(DBrowserNodeToggle)
  nmap <buffer> <CR> <Plug>(DBrowserEnterDirOrFile)
elseif (map_mode == 2) " Netrw mappings
  " TODO
endif

command! -nargs=0 DBrowserNodeExpand call dbrowser#nodeexpand()
command! -nargs=0 DBrowserNodeShrink call dbrowser#nodeshrink()
command! -nargs=0 DBrowserNodeToggle call dbrowser#nodetoggle()
command! -nargs=0 DBrowserEnterFile call dbrowser#enterfile()
command! -nargs=0 DBrowserEnterDir call dbrowser#enterdir()
command! -nargs=0 DBrowserEnterParent call dbrowser#enterdir('..')
command! -nargs=0 DBrowserRefresh call dbrowser#refresh()
command! -nargs=0 DBrowserConcealToggle let &l:conceallevel=(&l:conceallevel>0?0:2)

let b:undo_ftplugin .= 'setlocal foldlevel< nu< rnu< cole< cocu< '.
      \ 'cursorline< |'.
      \ 'mapclear <buffer> | '.
      \ 'aug ftplugin_dbrowser|execute "au! * <buffer>"|aug end'

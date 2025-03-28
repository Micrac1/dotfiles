" Helpers {{{1
" Is directory {{{
function! dbrowser#is_directory(dir) abort
  return a:dir[-1:] == '/'
endfunction
"}}}

" Get current mode {{{
function! dbrowser#get_mode() abort
  let line = getline(2)

  if (line ==# '')
    return 0
  elseif (line[0] ==# '.')
    return 1
  else
    return 2
  endif
endfunction
"}}}

" Is node expanded {{{
function! dbrowser#is_expanded(line = 0) abort
  let line = a:line == 0 ? line('.') : a:line
  return line < line('$')
        \ && getline(line + 1) =~# '^\V' .. substitute(getline(line), '\\', '\\\\', 'g') .. '\.\+\$'
endfunction
"}}}

" Default sort {{{
function! dbrowser#sort_default(a, b) abort
  if (dbrowser#is_directory(a:a))
    return dbrowser#is_directory(a:b) ? (a:a <=# a:b ? -1 : 1) : -1
  else
    return dbrowser#is_directory(a:b) ? 1 : (a:a <=# a:b ? -1 : 1)
  endif
endfunction
"}}}

" Is synced {{{
function! dbrowser#is_synced(bufnr) abort
  return getbufvar(a:bufnr, '&ft') ==# 'dbrowser'
        \ && isdirectory(bufname(a:bufnr))
        \ && getbufvar(a:bufnr, '&buftype') ==# 'nofile'
endfunction
"}}}

" Is DB buffer {{{
function! dbrowser#is_db_buffer(bufnr) abort
  return getbufvar(a:bufnr, '&ft') ==# 'dbrowser'
        "\&& isdirectory(getline(1)))
endfunction
"}}}
"}}}1

" Tree operations {{{1
" Expand node {{{
" Returns the number of new nodes
function! dbrowser#node_expand() abort
  if (!dbrowser#is_db_buffer(bufnr())) | echo 'Not a dbrowser buffer!' | return 0 | endif
  if (getpos('.')[1] == 1) | echo 'Cannot expand root.' | return 0 | endif

  if (dbrowser#is_expanded())
    " TODO what to do if already expanded?
    echo 'Directory already expanded!'
    return 0
  endif

  return dbrowser#read_dir()
endfunction
"}}}

" Shrink node {{{
function! dbrowser#node_shrink() abort
  if (!dbrowser#is_db_buffer(bufnr())) | echo 'Not a dbrowser buffer!' | return 0 | endif
  if (getpos('.')[1] == 1) | echo 'Cannot shrink root.' | return 0 | endif

  let dir = getline('.')

  let closed = dbrowser#node_close()
  if (closed > 0)
    return closed
  endif

  " Attempt to close the parent
  let dir = substitute(dir, '[^/]\+/\?$', '', '')
  let dir = substitute(dir, '\\', '\\\\', 'g')
  call searchpos('\V\^' .. dir .. '\$', 'b')

  return dbrowser#node_close()
endfunction
"}}}

" Toggle node {{{
function! dbrowser#node_toggle() abort
  if (!dbrowser#is_db_buffer(bufnr())) | echo 'Not a dbrowser buffer!' | return 0 | endif
  if (getpos('.')[1] == 1) | echo 'Cannot toggle root.' | return 0 | endif

  if (dbrowser#node_expand() == 0)
    call dbrowser#node_close()
  endif
endfunction
"}}}

" Close node {{{
" Returns number of deleted nodes
function! dbrowser#node_close() abort
  if (!dbrowser#is_db_buffer(bufnr())) | echo 'Not a dbrowser buffer!' | return 0 | endif

  let dir = getline('.')

  let save = getcurpos()
  call cursor('$', 999999)
  let dir = substitute(dir, '\\', '\\\\', 'g')
  let targets = searchpos('\V\^' .. dir .. '\.\+\$', 'bn')
  call setpos('.', save)
  if (targets[0] > 0)
    let from = line('.') + 1
    let to = targets[0]
    let mod = &l:modifiable | setl modifiable
    call deletebufline(bufnr(), from, to)
    let &l:modifiable = mod
    return to - from + 1
  endif
  return 0
endfunction
"}}}
"}}}1

" Open directory or file {{{
function! dbrowser#enter_dir_or_file() abort
  return dbrowser#enter_dir() ? v:true : dbrowser#enter_file()
endfunction
"}}}

" Read directory {{{
" Returns the number of appended files
function! dbrowser#read_dir(mode = 0) abort
  if (!dbrowser#is_db_buffer(bufnr())) | echo 'Not a dbrowser buffer!' | return 0 | endif

  let dir = getline('.')
  let dir_abs = dir[0] == '.' ? getline(1) .. dir : fnamemodify(dir,' :p')

  if (!isdirectory(dir_abs)) | echo 'Not a directory.' | return 0 | endif

  let files = readdir(dir_abs)

  if (len(files) == 0)
    return 0
  endif

  " TODO handle default mode
  if (a:mode == 1)
    let dir = './'
  endif
  " if (getpos('.')[1] == 1)
  "   let dir = './'
  " endif

  let i = 0
  while i < len(files)
    if isdirectory(dir_abs .. files[i])
      let files[i] .= '/'
    endif

    let files[i] = dir .. files[i]
    let i += 1
  endwhile

  call sort(files, function('dbrowser#sort_default'))

  let mod = &l:modifiable | setl modifiable
  call append(line('.'), files)
  let &l:modifiable = mod
  return len(files)
endfunction
"}}}

" Refresh {{{
function! dbrowser#refresh(mode = 0, keep_expanded = v:true) abort
  if (!dbrowser#is_db_buffer(bufnr())) | echo 'Not a dbrowser buffer!' | return v:false | endif
  let dir_abs = fnamemodify(bufname(), ':p')

  let mode = a:mode == 0 ? dbrowser#get_mode() : a:mode
  let save = getcurpos()

  " Overwrite the first line if the current buffer is a directory
  if (dbrowser#is_synced(bufnr()))
    execute 'silent! file ' .. fnameescape(dir_abs)
    let mod = &l:modifiable | setl modifiable
    call setline(1, dir_abs)
    let &l:modifiable = mod
  endif

  if (a:keep_expanded && getline(1) ==# dir_abs)
    " Perform soft refresh

    " Remebmer all expanded nodes
    let expanded = []
    let i = 2
    while i < line('$')
      if (dbrowser#is_expanded(i))
        call add(expanded, getline(i))
      endif
      let i += 1
    endwhile

    " Perform simple refresh
    let mod = &l:modifiable | setl modifiable
    call setline(1, dir_abs)
    call deletebufline(bufnr(), 2, '$')
    let &l:modifiable = mod
    echom expanded

    call dbrowser#read_dir(mode)

    " Expand nodes again
    call cursor(1, 1)

    for e in expanded
      if (search('\V\^' .. substitute(e, '\\', '\\\\', 'g') .. '\$', '') > 0)
        call dbrowser#node_expand()
      endif
    endfor
  else
    " Perform simple refresh
    let mod = &l:modifiable | setl modifiable
    call setline(1, dir_abs)
    call deletebufline(bufnr(), 2, '$')
    let &l:modifiable = mod

    call dbrowser#read_dir(mode)
  endif
  call setpos('.', save)
endfunction
"}}}

" Mode set {{{
function! dbrowser#mode_set(mode = 0) abort
  if (!dbrowser#is_db_buffer(bufnr())) | echo 'Not a dbrowser buffer!' | return v:false | endif
  let mode = a:mode
  if (mode == 0) " Toggle
    " Check the first item inside if present
    let line = getline(2)
    if (line[0] ==# '.')
      let mode = 2
    elseif (line[0] ==# '/')
      let mode = 1
    else
      return v:true
    endif
  endif

  let mod = &l:modifiable | setl modifiable
  let save = getcurpos()
  if (mode == 1) " Relative
    execute 'keepjumps 2,$s:\V\^' .. substitute(getline(1), ':', '\:', 'g') .. ':./:'
  elseif (mode == 2) " Absolute
    execute 'keepjumps 2,$s:\V\^./:' .. substitute(getline(1), ':', '\:', 'g') .. ':'
  endif
  call setpos('.', save)
  let &l:modifiable = mod
endfunction
"}}}

" Init synced buffer {{{
function! dbrowser#init_synced() abort
  setl buftype=nofile
  setl nomodifiable
  setl nobuflisted
  setl winfixwidth
  setl ft=dbrowser
endfunction
"}}}

" Enter file {{{
" Attempts to open the file under the cursor.
function! dbrowser#enter_file() abort
  if (!dbrowser#is_db_buffer(bufnr())) | echo 'Not a dbrowser buffer!' | return v:false | endif
  let filename = getline('.')

  if (dbrowser#is_directory(filename))
    echo 'Not a file!'
    return v:false
  endif

  let filename_escaped = fnamemodify(fnameescape(bufname() .. filename), ':p:.')

  " Open the file in previous window
  if (tabpagewinnr(tabpagenr(), '$') > 1)
    wincmd w
  else
    vsplit 
  endif

  execute 'edit ' .. filename_escaped
  return v:true
endfunction
"}}}

" Enter parent {{{
function! dbrowser#enter_parent(dir = '') abort
  if (!dbrowser#is_db_buffer(bufnr())) | echo 'Not a dbrowser buffer!' | return v:false | endif
  let dir = a:dir != '' ? a:dir : getline('.')

  return dbrowser#enter_dir(getline(1) .. '..')
endfunction
"}}}

" Enter directory {{{
function! dbrowser#enter_dir(dir = '', mode = 0) abort
  if (!dbrowser#is_db_buffer(bufnr())) | echo 'Not a dbrowser buffer!' | return v:false | endif
  let dir = a:dir != '' ? a:dir : getline('.')
  let dir = dir[0] == '.' ? getline(1) .. dir : dir
  let dir_abs = fnamemodify(dir, ':p')

  let mode = a:mode
  if (dbrowser#is_synced(bufnr())) " Only do this when 'synced'
    let mode = a:mode == 0 ? dbrowser#get_mode() : a:mode

    execute 'edit ' .. fnameescape(dir_abs)
    call dbrowser#init_synced()
  endif

  let mod = &l:modifiable | setl modifiable
  call setline(1, dir_abs)
  let &l:modifiable = mod

  return dbrowser#refresh(mode)
endfunction
"}}}

" Open DBbrowser without dir sync {{{
function! dbrowser#open_no_sync(dir = '', mode = 0) abort
  if (!dbrowser#is_db_buffer(bufnr())) | echo 'Not a dbrowser buffer!' | return v:false | endif
  let dir = a:dir != '' ? a:dir : '.'
  if (dir[-1:] !=# '/') | let dir .= '/' | endif

  let mod = &l:modifiable | setl modifiable
  call setline(1, fnamemodify(dir, ':p'))
  let &l:modifiable = mod

  return dbrowser#refresh(a:mode)
endfunction
"}}}

" Open DBbrowser {{{
function! dbrowser#open(dir = '', mode = 0, force = v:false) abort
  let dir = a:dir != '' ? a:dir : '.'
  if (dir[-1:] !=# '/') | let dir .= '/' | endif

  let dir_abs = fnamemodify(dir, ':p')
  if (!isdirectory(dir_abs))
    echo "Invalid directory: '" .. dir_abs .. "'"
    return v:false
  endif

  execute 'silent! edit ' .. fnameescape(dir_abs)
  call dbrowser#init_synced()

  return dbrowser#enter_dir(dir, a:mode)
endfunction
"}}}

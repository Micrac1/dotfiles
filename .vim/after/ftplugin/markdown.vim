" Options {{{
setl foldlevel=1
setl expandtab tabstop=3 softtabstop=-1 shiftwidth=0
"}}}

" Functions {{{

" Markdown TOC {{{
" Updates the TOC and opens QF window with proper concealing set
function! MarkdownTOC()
  " TODO check if we need to actually generate again (based on getlocinfo or sth)
  call MarkdownLocListGenerate()
  execute "lopen | syntax match Conceal /^[^|]*|[^|]*|\s*/ conceal | setl conceallevel=2 concealcursor=nc nowrap"
endfunction
"}}}

" Markdown mode for viewing {{{
function! MarkdownMode(mode = 0) " 0 - edit, 1 - view
  if (a:mode)
    setl nonu nornu conceallevel=2
  else
    setl nonu< nornu< conceallevel< concealcursor<
  endif
  return ''
endfunction
"}}}

" Markdown generate location list {{{
" Generates location list for the current window. Does not chceck filetype
function! MarkdownLocListGenerate()
  let winid = win_getid()
  " Do nothing if opened from a quickfix window (should not happen)
  if getwininfo(winid)[0]["quickfix"]|return ''|endif

  let locinfo = getloclist(winid,{"filewinid":0})
  let winnr = win_id2win(winid)

  let bufnr = winbufnr(winnr)
  let lines = getbufline(bufnr, 1, "$")
  let cur_line = getcurpos(win_id2win(winbufnr(locinfo["filewinid"])))[1]
  let new_idx = 1
  let items = []

  for i in range(0,len(lines)-1)
    let col = match(lines[i], "^#\\+\\s\\+\\zs")
    if (col >= 0)
      call add(items, {
            \ 'bufnr': bufnr,
            \ 'lnum': i+1,
            \ 'text': repeat('-',col-2).."▶ "..lines[i][col:-1]})
      if (i < cur_line)|let new_idx = len(items)|endif
    endif
  endfor
  noautocmd call setloclist(winnr, [], 'r', {
        \ 'title' : "Headings for "..bufname(bufnr),
        \ 'idx' : new_idx,
        \ 'items' : items})
  return ""
endfunction
"}}}

" Update cursor position {{{
function! MarkdownLocListRefreshPos()
  let locinfo = getloclist(win_getid(),{"filewinid":0, "items":0, "idx":0})
  let winnr = win_id2win(winbufnr(locinfo["filewinid"]))

  let new_idx = locinfo["idx"]
  if (!new_idx)|return ''|endif
  let cur_line = getcurpos(winnr)[1]
  while (new_idx < len(locinfo["items"]) && locinfo["items"][new_idx]["lnum"] <= cur_line)
    let new_idx += 1
  endwhile
  while (new_idx > 0 && locinfo["items"][new_idx-1]["lnum"]  > cur_line)
    let new_idx -= 1
  endwhile
  noautocmd call setloclist(winnr, [], 'r', {'idx' : new_idx})
  return ''
endfunction
"}}}

"}}}

" Mappings {{{
nnoremap <buffer> <expr> <localleader>b SurroundWithStrings("**", "**")
vnoremap <buffer> <expr> <localleader>b SurroundWithStrings("**", "**")
nnoremap <buffer> <expr> <localleader>i SurroundWithStrings("_", "_")
vnoremap <buffer> <expr> <localleader>i SurroundWithStrings("_", "_")
nnoremap <buffer> <expr> <localleader>s SurroundWithStrings("~~", "~~")
vnoremap <buffer> <expr> <localleader>s SurroundWithStrings("~~", "~~")
nnoremap <buffer> <silent> Q :MarkdownTOC<CR>
nnoremap <buffer> <localleader>v :call MarkdownMode(1)<CR>:echo "View mode"<CR>
nnoremap <buffer> <localleader>e :call MarkdownMode(0)<CR>:echo "Edit mode"<CR>
nnoremap <buffer> <localleader>p :MarkdownPreviewToggle<CR>:echo "Toggled preview"<CR>

inoremap <buffer> <C-a>i __<C-G>U<left>
inoremap <buffer> <C-a>b ****<C-G>U<left><C-G>U<left>
inoremap <buffer> <C-a>s ~~~~<C-G>U<left><C-G>U<left>

let s:list_pattern = '^\s*\zs\(- \(\[[X ]\] \)\?\\|[0-9]\+\. \)\?\ze[^$]'

execute 'nnoremap <buffer> <silent> <localleader>c :keeppatterns s/'..s:list_pattern..'//<CR>'
execute 'vnoremap <buffer> <silent> <localleader>c :keeppatterns s/'..s:list_pattern..'//<CR>'
execute 'nnoremap <buffer> <silent> <localleader>t :keeppatterns s/'..s:list_pattern..'/- [X] /<CR>'
execute 'vnoremap <buffer> <silent> <localleader>t :keeppatterns s/'..s:list_pattern..'/- [X] /<CR>'
execute 'nnoremap <buffer> <silent> <localleader>l :keeppatterns s/'..s:list_pattern..'/- /<CR>'
execute 'vnoremap <buffer> <silent> <localleader>l :keeppatterns s/'..s:list_pattern..'/- /<CR>'
execute 'nnoremap <buffer> <silent> <localleader>n :keeppatterns s/'..s:list_pattern..'/1. /<CR>'
execute 'vnoremap <buffer> <silent> <localleader>n :keeppatterns s/'..s:list_pattern..'/1. /<CR>'
"}}}

" Commands {{{
command! -buffer MarkdownTOC call MarkdownTOC()
command! -buffer MarkdownEditMode call MarkdownMode(0)
command! -buffer MarkdownViewMode call MarkdownMode(1)
"}}}

aug ftplugin_markdown
  au! * <buffer>
  au InsertLeave  <buffer> call MarkdownLocListGenerate()
  au TextChanged  <buffer> call MarkdownLocListGenerate()
  au CursorMoved  <buffer> call MarkdownLocListRefreshPos()
  au CursorMovedI <buffer> call MarkdownLocListRefreshPos()
aug end

if !exists('b:undo_ftplugin')|let b:undo_ftplugin=''|endif
let b:undo_ftplugin.='|mapclear <buffer>|setl foldlevel< nu< rnu< conceallevel<|'.
      \ 'aug ftplugin_markdown|execute "au! * <buffer>"|aug end'

if 'dbrowser' !=# get(b:, 'current_syntax', 'dbrowser')
  finish
endif

" let s:sep = exists('+shellslash') && !&shellslash ? '\\' : '/'
" let s:escape = 'substitute(escape(v:val, ".$~"), "*", ".*", "g")'

" Define once (per buffer).
if !exists('b:current_syntax')
  syntax match DBrowserTreePath =^.*/\ze.\+/\?$=
  syntax match DBrowserTreePathSep =\zs/\ze[^/]\+/[^/]\+=
        \ contained containedin=DBrowserTreePath conceal cchar= 
  syntax match DBrowserTreePathSepLast =/\ze[^/]\+/\?$=
        \ contained containedin=DBrowserTreePath conceal cchar=─
  syntax match DBrowserTreePathPart =[^/]\+\ze/[^/]\+/[^/]\+=
        \ contained containedin=DBrowserTreePath conceal cchar=│
  syntax match DBrowserTreePathPartLast =[^/]\+\ze/[^/]\+/\?$=
        \ contained containedin=DBrowserTreePath conceal cchar=├

  syntax match DBrowserFlatPath =^/.*/\ze.\+/\?$= conceal
  syntax match DBrowserHeader =\%^.*$= contains=DBrowserPathDirectory

  syntax match DBrowserPathDirectory =[^/]\+/$=
  syntax match DBrowserPathFile =[^/]\+$=
endif

highlight default link DBrowserHeader CursorLine
highlight default link DBrowserTreePathSep SpecialKey
highlight default link DBrowserTreePathSepLast Constant
highlight default link DBrowserTreePathPart SpecialKey
highlight default link DBrowserTreePathPartLast PreProc
highlight default link DBrowserPathDirectory Statement
highlight default link DBrowserPathFile Type
" highlight link Conceal Normal

let b:current_syntax = 'dbrowser'

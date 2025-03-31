if 'dbrowser' !=# get(b:, 'current_syntax', 'dbrowser')
  finish
endif

let s:sep = exists('+shellslash') && !&l:shellslash ? '\\' : '/'
" let s:escape = 'substitute(escape(v:val, ".$~"), "*", ".*", "g")'

" Define once (per buffer).
if !exists('b:current_syntax')
  execute 'syntax match DBrowserTreePath =^\..*'..s:sep..'\ze.\+'..s:sep..'\?$='
  execute 'syntax match DBrowserTreePathSep =\zs'..s:sep..'\ze'
        \..'[^'..s:sep..']\+'..s:sep..'[^'..s:sep..']\+='
        \..' contained containedin=DBrowserTreePath conceal cchar= '

  execute 'syntax match DBrowserTreePathSepLast ='..s:sep..'\ze'
        \..'[^'..s:sep..']\+'..s:sep..'\?$='
        \..' contained containedin=DBrowserTreePath conceal cchar=─'

  execute 'syntax match DBrowserTreePathPart =[^'..s:sep..']\+\ze'
        \..s:sep..'[^'..s:sep..']\+'..s:sep..'[^'..s:sep..']\+='
        \..' contained containedin=DBrowserTreePath conceal cchar=│'

  execute 'syntax match DBrowserTreePathPartLast =[^'..s:sep..']\+\ze'
        \..s:sep..'[^'..s:sep..']\+'..s:sep..'\?$='
        \..' contained containedin=DBrowserTreePath conceal cchar=├'


  execute 'syntax match DBrowserFlatPath =^[^\.].*'..s:sep..'\ze'
        \..'.\+'..s:sep..'\?$= conceal'

  execute 'syntax match DBrowserHeader =\%^.*$= contains=DBrowserPathDirectory'

  execute 'syntax match DBrowserPathDirectory =[^'..s:sep..']\+'..s:sep..'$='
  execute 'syntax match DBrowserPathFile =[^'..s:sep..']\+$='
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

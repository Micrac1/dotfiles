if exists("b:current_syntax")
  "finish
endif

syn match noteCheckbox "\s*\[.\].*$" nextgroup=noteName
hi! def noteCheckbox ctermfg=Gray

" syn region noteName start="\s\+"hs=e+1 end="\s\+-.*$"he=s-1
" hi def link noteName Label


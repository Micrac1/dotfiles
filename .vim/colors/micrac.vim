hi clear
set bg=dark
"TODO light version with inverted dark and light colors for everything
if (&t_Co > 16)
  let &t_Co=16
endif
let g:colors_name = "micrac"

hi!       Normal           guifg=White guibg=Black
hi!       SpecialKey       term=bold cterm=NONE ctermfg=DarkGray ctermbg=NONE guifg=DarkGray guibg=NONE
hi!       NonText          term=bold ctermfg=Blue gui=bold guifg=Cyan
hi! link  EndOfBuffer      NonText
hi!       Directory        term=bold ctermfg=159 guifg=Cyan "TODO

hi!       ErrorMsg         term=reverse,underline cterm=NONE    ctermfg=15   gui=NONE ctermbg=1 guifg=White guibg=Red
hi!       WarningMsg       term=reverse           cterm=NONE    ctermfg=Yellow  gui=NONE guifg=Yellow guibg=NONE
hi!       MoreMsg          term=bold cterm=bold   ctermfg=Green ctermbg=NONE gui=bold guifg=Green guibg=NONE
hi!       ModeMsg          term=bold cterm=bold gui=bold

hi!       IncSearch        term=reverse cterm=bold ctermfg=Black ctermbg=Green gui=bold guifg=Black guibg=Green
hi!       Search           term=reverse cterm=NONE ctermfg=Black ctermbg=Yellow gui=NONE guifg=Black guibg=Yellow
hi! link  CurSearch        Search

hi!       LineNr           term=NONE ctermfg=Yellow ctermbg=NONE gui=NONE guifg=Yellow guibg=NONE
hi! link  LineNrAbove      LineNr
hi! link  LineNrBelow      LineNr

hi!       CursorLine       term=reverse cterm=reverse   ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi! link  CursorLineNr     LineNr
hi! link  CursorLineFold   FoldColumn
hi! link  CursorLineSign   SignColumn

hi!       CursorColumn     term=reverse cterm=reverse ctermfg=NONE ctermbg=NONE gui=reverse guifg=NONE guibg=NONE
hi!       ColorColumn      term=reverse cterm=reverse ctermfg=DarkRed ctermbg=NONE gui=reverse guifg=DarkRed guibg=NONE

hi!       Question         term=standout ctermfg=121 gui=bold guifg=Green
hi!       Title            term=bold ctermfg=225 gui=bold guifg=LightMagenta
hi!       Visual           term=reverse cterm=NONE ctermfg=Black ctermbg=Gray guifg=LightGrey guibg=#575757
hi!       VisualNOS        term=bold,underline cterm=bold,underline gui=bold,underline
hi!       WildMenu         term=standout ctermfg=0 ctermbg=11 guifg=Black guibg=Yellow

hi!       Conceal          term=NONE cterm=NONE ctermfg=Gray ctermbg=DarkGray gui=NONE guifg=Grey guibg=DarkGrey
hi!       Folded           term=standout ctermfg=Cyan ctermbg=DarkGray gui=NONE guifg=Cyan guibg=DarkGray
hi! link  FoldColumn       Normal
hi! link  SignColumn       Normal

hi!       DiffAdd          term=bold    cterm=NONE ctermfg=NONE ctermbg=DarkGreen   gui=NONE guifg=NONE guibg=DarkGreen
hi!       DiffChange       term=bold    cterm=NONE ctermfg=NONE ctermbg=DarkMagenta gui=NONE guifg=NONE guibg=DarkMagenta
hi!       DiffDelete       term=bold    cterm=NONE ctermfg=Red ctermbg=DarkRed    gui=bold guifg=Red guibg=DarkRed
hi!       DiffText         term=reverse cterm=bold ctermfg=NONE ctermbg=DarkBlue gui=bold guifg=NONE guibg=Blue


hi!       SpellBad         term=reverse   cterm=underline ctermfg=White ctermbg=DarkRed     gui=underline guifg=White guibg=DarkRed
hi!       SpellCap         term=reverse   cterm=underline ctermfg=White ctermbg=DarkBlue    gui=underline guifg=White guibg=DarkBlue
hi!       SpellRare        term=reverse   cterm=underline ctermfg=White ctermbg=DarkMagenta gui=underline guifg=White guibg=DarkMagenta
hi!       SpellLocal       term=underline cterm=underline ctermfg=White ctermbg=DarkCyan    gui=underline guifg=White guibg=DarkCyan
" asdjakls
hi!       Pmenu            term=NONE    cterm=NONE    ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
hi!       PmenuSel         term=reverse cterm=reverse ctermfg=Blue ctermbg=NONE gui=NONE guifg=Blue guibg=DarkGray
hi! link  PmenuMatch       Pmenu
hi! link  PmenuMatchSel    PmenuSel
hi! link  PmenuKind        Pmenu
hi! link  PmenuKindSel     PmenuSel
hi! link  PmenuExtra       Pmenu
hi! link  PmenuExtraSel    PmenuSel
hi!       PmenuSbar        term=reverse cterm=NONE ctermfg=NONE ctermbg=Gray     guifg=NONE guibg=Grey
hi!       PmenuThumb       term=NONE    cterm=NONE ctermfg=NONE ctermbg=DarkGray guifg=NONE guibg=DarkGray

hi!       TabLine          term=reverse cterm=reverse ctermfg=NONE ctermbg=NONE gui=reverse guifg=NONE guibg=NONE
hi!       TabLineSel       term=bold    cterm=bold    ctermfg=NONE ctermbg=NONE gui=bold guifg=NONE guibg=NONE
hi! link  TabLineFill      TabLine

hi!       VertSplit        term=reverse      cterm=reverse      gui=reverse
hi!       StatusLine       term=bold,reverse cterm=bold,reverse gui=bold,reverse
hi!       StatusLineNC     term=reverse      cterm=reverse      gui=reverse
hi!       StatusLineTerm   term=bold,reverse cterm=bold ctermfg=Green ctermbg=DarkGreen gui=bold guifg=Black guibg=Green
hi!       StatusLineTermNC term=reverse      cterm=NONE ctermfg=Black ctermbg=DarkGreen gui=NONE guifg=Black guibg=Green

hi! link  QuickFixLine     Search
hi! clear MsgArea
hi!       Cursor           guifg=bg guibg=fg
hi!       lCursor          guifg=bg guibg=fg
hi!       MatchParen       term=reverse cterm=NONE ctermbg=DarkCyan guibg=DarkCyan

hi!       ToolbarLine      term=reverse   cterm=NONE ctermfg=NONE  ctermbg=DarkGray gui=NONE guifg=NONE  guibg=DarkGray
hi!       ToolbarButton    term=underline cterm=bold ctermfg=Black ctermbg=Gray     gui=bold guifg=Black guibg=Grey

" Language

hi!       Added            term=reverse cterm=NONE ctermfg=Green ctermbg=NONE gui=NONE guifg=Green guibg=NONE
hi!       Changed          term=reverse cterm=NONE ctermfg=Magenta  ctermbg=NONE gui=NONE guifg=LightMagenta guibg=NONE
hi!       Removed          term=reverse cterm=NONE ctermfg=Red   ctermbg=NONE gui=NONE guifg=Red guibg=NONE

hi!       Comment          term=bold      cterm=NONE      ctermfg=Cyan ctermbg=NONE gui=NONE guifg=Cyan guibg=NONE
hi!       Underlined       term=underline cterm=underline ctermfg=Blue ctermbg=NONE gui=underline guifg=#80a0ff guibg=NONE
hi!       Ignore           ctermfg=0 guifg=bg "TODO
hi!       Error            term=reverse,underline cterm=NONE ctermfg=Black ctermbg=Red    gui=NONE guifg=Black guibg=Red
hi!       Todo             term=reverse           cterm=NONE ctermfg=Black ctermbg=Yellow gui=NONE guifg=Black guibg=Yellow

hi!       Constant         term=NONE cterm=NONE ctermfg=Magenta ctermbg=NONE gui=NONE guifg=LightMagenta guibg=NONE
hi! link  String           Constant
hi! link  Character        Constant
hi! link  Boolean          Constant
hi! link  Number           Constant
hi! link  Float            Number

hi!       Identifier       term=bold cterm=bold ctermfg=Yellow ctermbg=NONE gui=NONE guifg=Yellow guibg=NONE
hi! link  Function         Identifier

hi!       Special          term=bold cterm=bold ctermfg=Yellow ctermbg=NONE gui=NONE guifg=Yellow guibg=NONE
hi! link  Tag              Special
hi! link  SpecialChar      Special
hi! link  Delimiter        Special
hi! link  SpecialComment   Special
hi! link  Debug            Special

hi!       Statement        term=bold cterm=bold ctermfg=Cyan ctermbg=NONE gui=bold guifg=Cyan guibg=NONE
hi! link  Conditional      Statement
hi! link  Repeat           Statement
hi! link  Label            Statement
hi! link  Operator         Statement
hi! link  Keyword          Statement
hi! link  Exception        Statement

hi!       PreProc          term=NONE cterm=NONE ctermfg=Cyan ctermbg=NONE gui=NONE guifg=Cyan guibg=NONE
hi! link  Include          PreProc
hi! link  Define           PreProc
hi! link  Macro            PreProc
hi! link  PreCondit        PreProc

hi!       Type             term=bold cterm=bold ctermfg=Green ctermbg=NONE gui=bold guifg=Green guibg=NONE
hi! link  StorageClass     Type
hi! link  Structure        Type
hi! link  Typedef          Type

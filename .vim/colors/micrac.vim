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
hi!       Cursor           guifg=bg guibg=#00aaff
hi! link  lCursor          Cursor
hi!       MatchParen       term=reverse cterm=NONE ctermbg=DarkCyan guibg=DarkCyan

hi!       ToolbarLine      term=reverse   cterm=NONE ctermfg=NONE  ctermbg=DarkGray gui=NONE guifg=NONE  guibg=DarkGray
hi!       ToolbarButton    term=underline cterm=bold ctermfg=Black ctermbg=Gray     gui=bold guifg=Black guibg=Grey

" Language {{{
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
"}}}

" termdebug {{{
hi!       debugPC                 term=reverse cterm=NONE ctermfg=NONE ctermbg=DarkBlue gui=NONE guifg=NONE guibg=DarkBlue
hi!       debugBreakpoint         term=reverse cterm=NONE ctermfg=NONE ctermbg=Red      gui=NONE guifg=NONE guibg=Red
hi!       debugBreakpointDisabled term=reverse cterm=NONE ctermfg=NONE ctermbg=Gray     gui=NONE guifg=NONE guibg=Gray
"}}}

" vim-lsp {{{
hi! link  lspReference                                                                       CursorColumn
hi!       LspErrorHighlight                                                                  cterm=underline ctermfg=Red ctermbg=NONE gui=underline guifg=Red guibg=NONE
hi!       LspWarningHighlight                                                                cterm=underline ctermfg=Yellow ctermbg=NONE gui=underline guifg=Red guibg=NONE
hi! link  LspInformationHighlight                                                            Normal
hi! link  LspHintHighlight                                                                   Normal
hi! link  LspErrorText                                                                       Error
hi! link  LspWarningText                                                                     Todo
hi! link  LspInformationText                                                                 Normal
hi! link  LspHintText                                                                        Normal
hi! clear LspErrorLine
hi! clear LspWarningLine
hi! clear LspInformationLine
hi! clear LspHintLine
hi! link  LspErrorVirtualText                                                                LspErrorText
hi! link  LspWarningVirtualText                                                              LspWarningText
hi! link  LspInformationVirtualText                                                          LspInformationText
hi! link  LspHintVirtualText                                                                 LspHintText
hi! link  LspCodeActionText                                                                  Normal
hi! clear LspCodeActionLine
hi! link  LspSemanticMacro                                                                   Macro
hi! link  LspSemanticGlobalScopeMacro                                                        LspSemanticMacro
hi! link  LspSemanticClass                                                                   Type
hi! link  LspSemanticDeclarationDefinitionFunctionScopeClass                                 LspSemanticClass
hi! link  LspSemanticType                                                                    Type
hi! link  LspSemanticFileScopeType                                                           LspSemanticType
hi! link  LspSemanticProperty                                                                Identifier
hi! link  LspSemanticClassScopeDeclarationProperty                                           LspSemanticProperty
hi! link  LspSemanticDeducedDefaultLibraryGlobalScopeClass                                   LspSemanticClass
hi! link  LspSemanticOperator                                                                Operator
hi! link  LspSemanticDeclarationDefinitionOperator                                           LspSemanticOperator
hi! link  LspSemanticFunctionScopeClass                                                      LspSemanticClass
hi! link  LspSemanticNamespace                                                               Normal
hi! link  LspSemanticGlobalScopeNamespace                                                    LspSemanticNamespace
hi! link  LspSemanticFunction                                                                Function
hi! link  LspSemanticGlobalScopeFunction                                                     LspSemanticFunction
hi! link  LspSemanticDeclarationDefinitionGlobalScopeClass                                   LspSemanticClass
hi! link  LspSemanticClassScopeDeclarationReadonlyProperty                                   LspSemanticProperty
hi! link  LspSemanticDeclarationGlobalScopeNamespace                                         LspSemanticNamespace
hi! link  LspSemanticGlobalScopeClass                                                        LspSemanticClass
hi! link  LspSemanticDefaultLibraryGlobalScopeNamespace                                      LspSemanticNamespace
hi! link  LspSemanticDefaultLibraryFileScopeClass                                            LspSemanticClass
hi! link  LspSemanticDefaultLibraryGlobalScopeClass                                          LspSemanticClass
hi! link  LspSemanticClassScopeStaticFunction                                                LspSemanticFunction
hi! link  LspSemanticClassScopeProperty                                                      LspSemanticProperty
hi! link  LspSemanticClassScopeReadonlyProperty                                              LspSemanticProperty
hi! link  LspSemanticEnumMember                                                              Constant
hi! link  LspSemanticClassScopeReadonlyEnumMember                                            LspSemanticEnumMember
hi! link  LspSemanticVariable                                                                Identifier
hi! link  LspSemanticGlobalScopeVariable                                                     LspSemanticVariable
hi! link  LspSemanticDeclarationDefinitionFunctionScopeVariable                              LspSemanticVariable
hi! link  LspSemanticFunctionScopeVariable                                                   LspSemanticVariable
hi! link  LspSemanticMethod                                                                  Function
hi! link  LspSemanticClassScopeMethod                                                        LspSemanticMethod
hi! link  LspSemanticClassScopeReadonlyMethod                                                LspSemanticMethod
hi! link  LspSemanticClassScopeConstructorOrDestructorDeclarationDefinitionGlobalScopeClass  LspSemanticClass
hi! link  LspSemanticClassScopeDeclarationReadonlyEnumMember                                 LspSemanticEnumMember
hi! link  LspSemanticUserDefinedOperator                                                     LspSemanticOperator
hi! link  LspSemanticDefaultLibraryFileScopeType                                             LspSemanticType
hi! link  LspSemanticDefaultLibraryGlobalScopeFunction                                       LspSemanticFunction
hi! link  LspSemanticDeclarationDefinitionGlobalScopeFunction                                LspSemanticFunction
"}}}

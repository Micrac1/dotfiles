function! CSFix()
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
  hi! link  lspInlayHintsType                                                                  Type
  hi! link  lspInlayHintsParameter                                                             SpecialKey
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
endfunction

" Fix LSP and Termdebug highlight after changing colorschemes {{{
aug csfix
  au!
  au ColorScheme * silent! call CSFix()
  au VimEnter * silent! call CSFix()
aug end
"}}}

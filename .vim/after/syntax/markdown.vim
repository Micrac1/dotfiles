" TODO make this less fragile to updates to included markdown.vim
syn region markdownLinkText matchgroup=markdownLinkTextDelimiter
      \ start="!\=\[\%(\_[^][]*\%(\[\_[^][]*\]\_[^][]*\)*]\%( \=[[(]\)\)\@="
      \ end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite
      \ contains=@markdownInline,markdownLineStart concealends
syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")"
      \ contains=markdownUrl keepend contained conceal


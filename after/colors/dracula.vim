" Make Go look better
hi goEscapeC ctermfg=84 ctermbg=NONE cterm=NONE guifg=#50fa7b guibg=NONE gui=NONE
hi goFormatSpecifier ctermfg=84 ctermbg=NONE cterm=NONE guifg=#50fa7b guibg=NONE gui=NONE

" An update to Dracula broke this so that specialkey is red. This causes
" invisibles to look red. I'm not sure what else this changes setting this
" but for day to day editing this fixes it. Keep an eye on whether dracula
" reverts.
hi SpecialKey guifg=#424450

" TSX
hi tsxTagName guifg=#E06C75
hi tsxCloseString guifg=#F99575
hi tsxCloseTag guifg=#F99575
hi tsxAttributeBraces guifg=#F99575
hi tsxEqual guifg=#F99575
hi tsxAttrib guifg=#F8BD7F cterm=italic

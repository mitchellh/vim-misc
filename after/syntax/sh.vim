" Vim syntax file
" Language: Shell -- Extended for Bats (Bash Automated Testing System)
" Maintainer: Ross Timson <ross@rosstimson.com>
" Version: 0.1.0
" Last Change: 22 June 2013

syn match batsTest              "\v\@test"
syn keyword batsKeyword         run containedin=shExpr contained

hi def link batsTest            Identifier
hi def link batsKeyword         Keyword

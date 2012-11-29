" Vim filetype detection file
" Language:     AsciiDoc
" Author:       Stuart Rackham <srackham@gmail.com>
" Last Change:  AsciiDoc 8.2.0
" URL:          http://www.methods.co.nz/asciidoc/
" Licence:      GPL (http://www.gnu.org)
" Remarks:      Vim 6 or greater

" COMMENT OUT ONE OF THE TWO FOLLOWING COMMANDS
" The first sets asciidoc syntax highlighting on all .txt files, the second
" only existing files *.txt that appear to be AsciiDoc files.

au BufNewFile,BufRead *.asciidoc,*.asc setfiletype asciidoc

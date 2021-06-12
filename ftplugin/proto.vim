setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2
setlocal expandtab

if has("nvim")
    " Fold via tree-sitter
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
endif

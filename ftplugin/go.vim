setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4
setlocal noexpandtab

if has("nvim")
    " Format prior to save using LSP
    autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)
endif

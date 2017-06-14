augroup filetype_python
    autocmd!
    autocmd BufNewFile,BufRead *.py
        \ set tabstop=2 |
        \ set softtabstop=2 |
        \ set shiftwidth=2 |
        \ set textwidth=79 |
        \ set expandtab |
        \ set autoindent |
        \ set fileformat=unix
augroup END

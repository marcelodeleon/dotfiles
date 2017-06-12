Plug 'ctrlpvim/ctrlp.vim'

let g:ctrlp_user_command = [
    \ '.git', 'cd %s && git ls-files . -co --exclude-standard',
    \ 'find %s -type f'
    \ ]
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40

Plug 'tacahiroy/ctrlp-funky'

nnoremap <C-F> :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
" nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

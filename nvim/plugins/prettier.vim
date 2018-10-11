" Install prettier and run post hook to install dependencies.
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
" Remap key binding to run prettier.
nmap <Leader>py <Plug>(Prettier)
" Force prittier to always be async.
let g:prettier#exec_cmd_async = 1

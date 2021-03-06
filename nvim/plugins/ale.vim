Plug 'w0rp/ale'

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_fixers = {
\   'javascript': ['eslint'],
\}

" Remove comments in the following lines to enable automatic formatting.
"autocmd bufwritepost *.js silent !standard --fix %
"set autoread

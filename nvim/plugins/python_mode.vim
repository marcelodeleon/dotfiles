" Plugin for everything Python
Plug 'klen/python-mode'

map <Leader>g <C-c>g
let g:pymode_breakpoint = 0
let g:pymode_syntax = 1
let g:pymode_syntax_builtin_objs = 0
let g:pymode_syntax_builtin_funcs = 0
map <Leader>b Oimport ipdb; ipdb.set_trace() #BREAKPOINT<C-c>

" Disable rope plugin
let g:pymode_rope = 0

" Autoremove unused whitespaces
let g:pymode_utils_whitespaces = 1

" Auto fix vim python paths if virtualenv enabled
let g:pymode_virtualenv = 1

" Set default pymode python indent options
let g:pymode_options_indent = 1

" Set default pymode python fold options
let g:pymode_options_fold = 1

" Set default pymode python other options
let g:pymode_options_other = 1

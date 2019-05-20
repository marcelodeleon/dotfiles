" Amazing asyncronous autocomplete plugin for neovim.
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Not needed but gives access to extra Tern features from inside vim.
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

" Integrates with deoplete and provides an easier way to access Tern completions.
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

" Provides great autocompletion features for function parameters.
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'ervandew/supertab'
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Use deoplete.
let g:deoplete#enable_at_startup = 1
" Make sure the autocompletion will actually trigger using the omnifuncs set later on.
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

" Automatically closes the scratch window at the top of the vim window.
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  " autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

set completeopt=longest,menuone,preview

" tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern#tern_show_argument_hints = 'on_hold'
  let g:tern#tern_show_signature_in_pum = 1
  " let g:deoplete#omni#functions = {}
  " let g:deoplete#omni#functions.javascript = [
  "   \ 'tern#Complete',
  "   \ 'jspc#omni'
  " \]
endif

" let g:deoplete#sources = {}
" let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']

" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent", "--no-port-file"]

" let g:deoplete#sources#ternjs#docs = 1
" let g:deoplete#sources#ternjs#types = 1

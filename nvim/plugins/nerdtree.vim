" NERDTree Sidebar
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Map it
map <Leader>n :NERDTreeToggle<CR>

" Show hidden files by default
let NERDTreeShowHidden=1

" Make it respect wildignore.
" This in combination with RootIgnore makes NERDTree hide files ignored in .gitignore.
let NERDTreeRespectWildIgnore=1

" Hide files from .gitignore
Plug 'octref/RootIgnore'

" Shows git status for files
Plug 'Xuyuanp/nerdtree-git-plugin'

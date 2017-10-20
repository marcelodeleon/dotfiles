" Todo plugin
Plug 'sdeleon28/vim-todo'

" NERDTree sidebar
source ~/.dotfiles/nvim/plugins/nerdtree.vim

" vim-airline and color scheme config
source ~/.dotfiles/nvim/plugins/theme.vim

" Deals with surroundings
Plug 'tpope/vim-surround'

" Project-wide, fuzzy filename search
source ~/.dotfiles/nvim/plugins/ctrlp.vim

" Adds nice icons to NERDTree, Ctrl-p and other plugins
Plug 'ryanoasis/vim-devicons'
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11
let g:airline_powerline_fonts = 1

" Comment stuff out
Plug 'tpope/vim-commentary'

" Async autocomplete plugin
source ~/.dotfiles/nvim/plugins/deoplete.vim

" Fugitive, awesome git wrapper
source ~/.dotfiles/nvim/plugins/fugitive.vim

" Adds Python related plugins
source ~/.dotfiles/nvim/plugins/python/python.vim

" Async Linter
source ~/.dotfiles/nvim/plugins/ale.vim

" Javascript syntax highlighter
Plug 'othree/yajs.vim'

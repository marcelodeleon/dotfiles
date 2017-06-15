" Todo plugin
Plug 'sdeleon28/vim-todo'

" NERDTree sidebar
source ~/.dotfiles/nvim/plugins/nerdtree.vim

" vim-airline and color scheme config
source ~/.dotfiles/nvim/plugins/theme.vim

" Plugin for everything Python
source ~/.dotfiles/nvim/plugins/python_mode.vim
" Deals with surroundings
Plug 'tpope/vim-surround'

" Project-wide, fuzzy filename search
source ~/.dotfiles/nvim/plugins/ctrlp.vim

" Adds nice icons to NERDTree, Ctrl-p and other plugins
Plug 'ryanoasis/vim-devicons'
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11
let g:airline_powerline_fonts = 1

" Simple Python Folding
source ~/.dotfiles/nvim/plugins/fold.vim

" I'm only using jedi-vim for go to def.
source ~/.dotfiles/nvim/plugins/jedi-vim.vim

" Comment stuff out
Plug 'tpope/vim-commentary'

" Async autocomplete plugin
source ~/.dotfiles/nvim/plugins/deoplete.vim

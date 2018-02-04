" NERDTree sidebar
source ~/.dotfiles/nvim/plugins/nerdtree.vim

" vim-airline and color scheme config
source ~/.dotfiles/nvim/plugins/theme.vim

" Deals with surroundings
Plug 'tpope/vim-surround'

" Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Insert/delete quotes, parens and the likes in pairs.
Plug 'jiangmiao/auto-pairs'

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

" Snippets!
source ~/.dotfiles/nvim/plugins/ultisnips.vim

" Javascript syntax highlighter
Plug 'othree/yajs.vim'

" Vim Wiki
Plug 'vimwiki/vimwiki'

" Sugar for UNIX commands.
" Specifically useful to rename open files in place.
Plug 'tpope/vim-eunuch'

" Allows to navigate vim and tmux panes as if they were the same.
Plug 'christoomey/vim-tmux-navigator'

" Calendar for vim, it integrates with vimwiki.
Plug 'git://github.com/mattn/calendar-vim'

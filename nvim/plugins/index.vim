" Allows to load quickfix list results to args.
Plug 'nelstrom/vim-qargs'

" It allows you to search the selected text using '*'
Plug 'nelstrom/vim-visual-star-search'

Plug 'metakirby5/codi.vim'

" Shows the CSS color inside vim
Plug 'ap/vim-css-color'

" Enable matchit plugin
runtime macros/matchit.vim

" Makes :E to run as :Explore and don't collide with :Emmet
command -nargs=* -complete=dir -bar -count -bang E :Explore<bang> <args>

Plug 'jparise/vim-graphql'

" Text object for a line and entire file
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'

" vim-airline and color scheme config
source ~/.dotfiles/nvim/plugins/theme.vim

" Deals with surroundings
Plug 'tpope/vim-surround'

" Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Use dot with plugin actions!
Plug 'tpope/vim-repeat'

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

" Great plugin for text search.
source ~/.dotfiles/nvim/plugins/ctrlsf.vim

" Adds Python related plugins
source ~/.dotfiles/nvim/plugins/python/python.vim

" Async Linter
source ~/.dotfiles/nvim/plugins/ale.vim

" Snippets!
source ~/.dotfiles/nvim/plugins/ultisnips.vim

" Javascript syntax highlighter
source ~/.dotfiles/nvim/plugins/javascript-syntax-highlighting.vim

" Expand CSS selectors into HTML or JSX
source ~/.dotfiles/nvim/plugins/emmet.vim

" Vim Wiki
Plug 'vimwiki/vimwiki'

" Sugar for UNIX commands.
" Specifically useful to rename open files in place.
Plug 'tpope/vim-eunuch'

" Allows to navigate vim and tmux panes as if they were the same.
Plug 'christoomey/vim-tmux-navigator'

" Calendar for vim, it integrates with vimwiki.
Plug 'git://github.com/mattn/calendar-vim'

source ~/.dotfiles/nvim/plugins/ack.vim
source ~/.dotfiles/nvim/plugins/markdown.vim
source ~/.dotfiles/nvim/plugins/gundo.vim

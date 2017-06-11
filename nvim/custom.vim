" Make searching better
set gdefault      " Never have to type /g at the end of search / replace again
set ignorecase    " case insensitive searching (unless specified)
set smartcase
set hlsearch
nnoremap <silent> <leader>, :noh<cr> " Stop highlight after searching
set incsearch
set showmatch

" Put swap and backup files outside project dir to keep it clean
set swapfile
set dir=~/tmp
set backup
set backupdir=~/tmp

" Automatically change dir when switching files.
" This enables :compl-filename to give me proper relative filenames.
set autochdir

" Use 4 spaces for indentation
set ts=4
set et
set sw=4

" Show invisible characters
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

"Invisible character colors 
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" Enable autoindent
set autoindent
set smartindent

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

" Sources the current vimscript
nnoremap <leader>sop :source %<cr>

" Set Chrome as the default browser
let g:netrw_browsex_viewer='google-chrome'

" Open image in gwenview
nnoremap <leader>i :!gwenview <cfile><cr><cr>

" Swaps paste mode
set pastetoggle=<F3>

" Configure status line
" set laststatus=2
" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Paste from clipboard
nmap <leader>p :put+<CR>

" Make it obvious where 120 characters is
set textwidth=120
" set formatoptions=cq
set formatoptions=qrn1
set wrapmargin=0
set colorcolumn=+1

" Open vertical splits on the right
set splitright

" Make searching better
set gdefault      " Never have to type /g at the end of search / replace again
set ignorecase    " case insensitive searching (unless specified)
set smartcase
set hlsearch
nnoremap <silent> <leader>, :noh<cr> " Stop highlight after searching
set incsearch
set showmatch
" Make '&' trigger the last search keeping any flags passed.
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Enables paragraph formatting with Unix 'par'
set formatprg=par

" Enable mouse
set mouse=a

" Make sure the current file and the working directory are in the path.
set path+=.,,

" Underline current line
set cursorline
hi clear CursorLine
hi CursorLine gui=underline cterm=underline

" Put swap and backup files outside project dir to keep it clean
set swapfile
set dir=~/tmp
set backup
set backupdir=~/tmp

" Automatically change dir when switching files.
" This enables :compl-filename to give me proper relative filenames.
set autochdir

" Use 2 spaces for indentation as default.
set ts=2
set et
set sw=2

" Use 2 spaces for indentation for Javascript
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

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

" Make it obvious where 110 characters is
set textwidth=110
" set formatoptions=cq
set formatoptions=qrn1
set wrapmargin=0
set colorcolumn=+1

" Open vertical splits on the right
set splitright
" Open horizontal splits at the bottom
set splitbelow

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Command history filter with <C-n> and <C-p>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

"Remove all leading whitespace by pressing F4
nnoremap <F4> :%s/^ \+//<CR>

" Allows to copy from vim and paste in the system clipboard
set clipboard=unnamed

" Set hidden buffers, so we can navigate away without saving.
set hidden

" Expands path of the active buffer in commmand-line mode when typing '%%'
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Quick file mappings
noremap <Leader>s :update<CR> 
noremap <Leader>w :q<CR> 
noremap <Leader>S :wa<CR> 

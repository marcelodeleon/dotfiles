" Create file under cursor
map <silent> <leader>gcf :!touch <cfile><cr><cr>

" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Print a timestamp for now.
map <silent> <leader>ct :r! date "+\%Y-\%m-\%d \%H:\%M:\%S"<CR>

" Print a timestamp for the current date.
map <silent> <leader>ctd :r! date "+\%Y-\%m-\%d"<CR>

" Custom commands
source ~/.dotfiles/nvim/commands/custom.vim

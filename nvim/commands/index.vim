" Create file under cursor
map <silent> <leader>gcf :!touch <cfile><cr><cr>

" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Custom commands
source ~/.dotfiles/nvim/commands/custom.vim

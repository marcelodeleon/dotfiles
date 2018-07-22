" Git wrapper
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Make vimdiff use vertical splits for 3-way merges
set diffopt=vertical

" Open `git lg` in new buffer
nnoremap <Leader>l :split gitlg.txt<CR>:r!git lg<CR>:AnsiEsc<CR>gg

" Deletes any Fugitive buffer after exiting
autocmd BufReadPost fugitive://* set bufhidden=delete

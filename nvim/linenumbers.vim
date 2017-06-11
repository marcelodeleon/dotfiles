function! NumberToggle()
  if &rnu == 0
    set nu
    set rnu
  else
    set nornu
    set nu
  endif
endfunc

nnoremap <C-l> :call NumberToggle()<cr>
" Use relative numbers by default and always include current line number
set rnu
set nu

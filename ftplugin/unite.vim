" Use F5 to force Unite to reload the file cache.
noremap <buffer> <F5> :execute "normal \<Plug>(unite_redraw)"<Return>
inoremap <buffer> <F5> <Esc>:execute "normal \<Plug>(unite_redraw)"<Return>i

" Make Escape and Ctrl+C close the Unite.vim buffer in normal mode.
noremap <buffer> <Esc> :q!<Return>
noremap <buffer> <C-c> :q!<Return>

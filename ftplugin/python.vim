let w:trim_insert_newline=0

setlocal expandtab
setlocal cc=80
" Enable comment continuation.
setlocal formatoptions+=cro
setlocal foldmethod=indent
setlocal foldminlines=10

if has('gui_running')
    setlocal spell
endif

" Multi-line commenting and uncommenting.
vmap <buffer> <C-m> :s/^\(\s*\)/\1#/<Return>
vmap <buffer> <C-,> :s/^\(\s*\)#/\1/<Return>
" Map Ctrl+R to alignment.
vmap <buffer> <C-r> :Align = :<Return>


let w:trim_insert_newline=1

setlocal expandtab
setlocal cc=80
" Enable comment continuation.
setlocal formatoptions+=cro

if has('gui_running')
    setlocal spell
endif

" Map Ctrl+R to alignment.
vmap <buffer> <C-r> :Align = :<Return>


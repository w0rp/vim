setlocal expandtab
setlocal cc=80

if has('gui_running')
    setlocal spell
endif

" Map Ctrl+R to alignment.
vmap <buffer> <C-r> :Align = :<Return>


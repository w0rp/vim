" Use more space for Java code.
setlocal cc=80

if has('gui_running')
    setlocal spell
endif

" Map Ctrl+R to alignment.
vmap <buffer> <C-r> :Align =<Return>

" Multi-line commenting and uncommenting.
vmap <buffer> <C-m> :s/^\(\s*\)/\1\/\//<Return>
vmap <buffer> <C-,> :s/^\(\s*\)\/\//\1/<Return>


" Use more space for Java code.
setlocal cc=80

if has('gui_running')
    setlocal spell
endif

" Multi-line commenting and uncommenting.
vmap <buffer> <C-m> :s/^\(\s*\)/\1\/\//<Return>
vmap <buffer> <C-,> :s/^\(\s*\)\/\//\1/<Return>

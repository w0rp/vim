let w:trim_insert_newline=0

setlocal expandtab
setlocal cc=80

if has('gui_running')
    setlocal spell
endif

" Map Ctrl+R to alignment.
vmap <buffer> <C-r> :Align = :<Return>

" Use rainbow parens for javascript
call rainbow#load()

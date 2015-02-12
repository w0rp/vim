let w:trim_insert_newline=0

setlocal noexpandtab
" Use more space for PHP code.
setlocal cc=132
" Enable comment leader continuation
setlocal formatoptions+=cro
" Combined with the plugin ctabs.vim, this will fix aligment and line
" continuation problems.
setlocal cindent

vmap <buffer> <C-r> :Align => =<Return>

if has('gui_running')
    setlocal spell
endif


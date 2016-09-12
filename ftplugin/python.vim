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

" Use the AutoPythonImport tool.
map <buffer> <C-n> :call AutoPythonImport()<Return>

function! ApplyAutopep8()
    " Save the current position.
    let l:line_number=line('.')
    let l:column_number=col('.')

    " Run autopep8 on every line.
    silent 0,$!autopep8 -

    " Jump back to the line number and cursor before, which might be a
    " little off.
    call cursor(l:line_number, l:column_number)

    echo "Re-formatted code with autopep8"
endfunction

map <buffer> <F8> :call ApplyAutopep8()<Return>

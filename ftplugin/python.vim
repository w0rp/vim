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

" Use the AutoPythonImport tool.
map <buffer> <C-n> :call AutoPythonImport(expand("<cword>"))<Return>

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

function! GeneratePythonSuperCall()
    let class_line = search('^class', 'bn')
    let def_line = search('^\s*def', 'bn')

    if class_line <= 0 || def_line <= 0
        return ''
    endif

    let class_match = matchlist(getline(class_line), '^class \+\([^(]\+\)(')

    if len(class_match) == 0
        return ''
    endif

    let class_name = class_match[1]

    let def_match = matchlist(getline(def_line), '^\s*def \+\([^(]\+\)(')

    if len(def_match) == 0
        return ''
    endif

    let method_name = def_match[1]

    let def_closing_line = def_line

    while def_closing_line != line('$') && len(matchlist(getline(def_closing_line), '):')) == 0
        def_closing_line += 1
    endwhile

    if def_closing_line == line('$')
        return ''
    endif

    " TODO Use line range to extract arguments.

    return 'super(' . class_name . ', self).' . method_name
endfunction

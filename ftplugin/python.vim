setlocal expandtab
setlocal colorcolumn=80
setlocal textwidth=79
" Enable comment continuation.
setlocal formatoptions+=cro
setlocal foldmethod=indent
setlocal foldminlines=10

" Multi-line commenting and uncommenting.
vmap <buffer> <C-m> :s/^\(\s*\)/\1#/<Return>
vmap <buffer> <C-,> :s/^\(\s*\)#/\1/<Return>

" Use the AutoPythonImport tool.
map <buffer> <C-n> :call AutoPythonImport(expand("<cword>"))<Return>

map <buffer> <F9> <Plug>(python_tools_pytest_class_reuse_db)
map <buffer> <C-F9> <Plug>(python_tools_pytest_class)

" Change the line length for Python files based on configuration files.
function! ChangeLineLength() abort
    let l:conf = ale#path#FindNearestFile(bufnr(''), 'setup.cfg')

    if !empty(l:conf)
        for l:match in ale#util#GetMatches(
        \   readfile(l:conf),
        \   '\v^ *max-line-length *\= *(\d+)',
        \)
            let l:line_length = str2nr(l:match[1])
            let &colorcolumn = l:line_length + 1
            let &textwidth = l:line_length
        endfor
    else
        " Reset settings back to defaults when configuration files are not
        " found.
        setlocal colorcolumn=80
        setlocal textwidth=79
    endif

    " Don't automatically split long lines for Django migration files.
    if expand('%:p') =~# '/migrations/'
        setlocal textwidth=0
    endif
endfunction

call ChangeLineLength()

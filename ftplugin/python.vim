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

let b:line_length = 79

" Change the line length for Python files based on configuration files.
function! ChangeLineLength() abort
    let l:conf = ale#path#FindNearestFile(bufnr(''), 'setup.cfg')
    " Reset settings back to defaults when configuration files are not found
    let b:line_length = 79

    " Find the max line length from the configuration file.
    for l:line in (!empty(l:conf) ? readfile(l:conf) : [])
        let l:match = matchlist(l:line, '\v^ *max-line-length *\= *(\d+)')

        if !empty(l:match)
            let b:line_length = str2nr(l:match[1])
            break
        endif
    endfor

    let &l:colorcolumn = b:line_length + 1
    let &l:textwidth = b:line_length

    " Don't automatically split long lines for Django migration files.
    if expand('%:p') =~# '/migrations/'
        setlocal textwidth=0
    endif
endfunction

function! DisableTextWidthForCertainLines() abort
    let l:line = getline('.')

    if l:line =~# '^\s*from'
        " Disable textwidth for long import lines
        setlocal textwidth=0
    else
        let &l:textwidth = b:line_length
    endif
endfunction

augroup PythonInsertEvents
    autocmd!
    autocmd InsertCharPre,CompleteDone <buffer> call DisableTextWidthForCertainLines()
augroup END

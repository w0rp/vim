" Use tabs for Go code, display them as 4 spaces.
setlocal noexpandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal nospell
" Make the colorcolumn wider for Go, where code is typically longer.
setlocal colorcolumn=121

vnoremap <buffer> <C-Space> :EasyAlign *\<Space><Return>

let b:ale_go_goimports_executable = $HOME . '/go/bin/goimports'
let b:ale_linters = ['gopls']
let b:ale_fixers = ['goimports']
let b:ale_fix_on_save = 1

function! UpdateGoTestPath() abort
    let l:mod_file = ale#path#FindNearestFile(bufnr(''), 'go.mod')

    if !empty(l:mod_file)
        let l:dir = ale#path#Dirname(l:mod_file)
        let l:rel_path = substitute(expand('%:p'), '^' . l:dir . '/', '', '')
        let l:first = split(l:rel_path, '/')[0]

        let b:test_command = ale#command#CdString(l:dir)
        \   . ' go test'
        \   . ' ./' . ale#Escape(l:first) . '/...'
    else
        let b:test_command = ''
    endif
endfunction

augroup UpdateGoTestPathGroup
    autocmd! * <buffer>
    autocmd BufEnter <buffer> call UpdateGoTestPath()
augroup END

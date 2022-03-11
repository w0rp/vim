let b:ale_linters = ['gopls']

" Use tabs for Go code, display them as 4 spaces.
setlocal noexpandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal nospell
" Make the colorcolumn wider for Go, where code is typically longer.
setlocal colorcolumn=121

vnoremap <buffer> <C-Space> :EasyAlign *\<Space><Return>

let g:test#enabled_runners = ['go#gotest']
let g:test#go#runner = 'gotest'

function! UpdateGoTestPath() abort
    let l:mod_file = ale#path#FindNearestFile(bufnr(''), 'go.mod')

    if !empty(l:mod_file)
        let g:test#go#gotest#executable =
        \   ale#command#CdString(ale#path#Dirname(l:mod_file))
        \   . ' go test'
    else
        let g:test#go#gotest#executable = 'go test'
    endif
endfunction

map <buffer> <silent> <F9> :TestFile<CR>

augroup UpdateGoTestPathGroup
    autocmd! * <buffer>
    autocmd BufEnter <buffer> call UpdateGoTestPath()
augroup END

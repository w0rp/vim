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

let g:test#go#runner = 'gotest'

let s:mod_file = ale#path#FindNearestFile(bufnr(''), 'go.mod')

if !empty(s:mod_file)
    let g:test#go#gotest#executable =
    \   ale#command#CdString(ale#path#Dirname(s:mod_file))
    \   . ' go test'
endif

map <buffer> <silent> <F9> :TestFile<CR>

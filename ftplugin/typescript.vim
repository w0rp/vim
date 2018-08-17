setlocal expandtab
setlocal colorcolumn=81
" Use 2 space tabs for TypeScript
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal nospell
" Include - for completion.
setlocal iskeyword+=-

map <buffer> <silent> <F9> :TestFile<CR>

let b:ale_completion_excluded_words = ['it', 'describe', 'beforeEach', 'import']

let s:dir = ale#path#Dirname(ale#path#FindNearestDirectory(bufnr(''), 'node_modules'))

if !empty(s:dir)
    let g:test#javascript#jest#executable = s:dir . '/node_modules/.bin/jest'
    let g:test#project_root = s:dir
endif

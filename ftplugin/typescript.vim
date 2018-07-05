setlocal expandtab
setlocal colorcolumn=81
" Use 2 space tabs for TypeScript
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal nospell
" Include - for completion.
setlocal iskeyword+=-

map <buffer> <F9> :w<CR><Plug>(run_jasmine_tests)
inoremap <buffer> ; :
inoremap <buffer> : ;

let b:ale_completion_excluded_words = ['it', 'describe', 'beforeEach', 'import']

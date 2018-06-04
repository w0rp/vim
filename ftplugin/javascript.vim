setlocal expandtab
setlocal colorcolumn=81
" Use 2 space tabs for JavaScript
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal nospell

map <buffer> <F9> :w<CR><Plug>(run_jasmine_tests)
" Swap ; and : in TS code, to make my left wrist hurt less.
inoremap <buffer> ; :
inoremap <buffer> : ;

let b:ale_linters = ['eslint']

setlocal expandtab
setlocal colorcolumn=81
setlocal spell

setlocal formatoptions=croql
" Continue \ lines after one is found.
setlocal comments=sO:\"\ -,mO:\"\ \ ,eO:\"\",b:\\

let b:ale_completion_excluded_words = [
\   'function',
\   'funcref',
\]

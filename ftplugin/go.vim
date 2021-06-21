let b:ale_linters = ['gofmt', 'gopls', 'staticcheck']

" Use tabs for Go code, display them as 4 spaces.
setlocal noexpandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal nospell
" Make the colorcolumn wider for Go, where code is typically longer.
setlocal colorcolumn=121

vnoremap <buffer> <C-Space> :EasyAlign *\<Space><Return>

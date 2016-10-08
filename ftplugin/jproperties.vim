setlocal noexpandtab

" Multi-line commenting and uncommenting.
vmap <buffer> <C-m> :s/^\(\s*\)/\1\/\//<Return>
vmap <buffer> <C-,> :s/^\(\s*\)\/\//\1/<Return>


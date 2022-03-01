setlocal expandtab

if has('gui_running')
    setlocal spell
endif

" Multi-line commenting and uncommenting.
vmap <buffer> <C-m> :s/^\(\s*\)/\1#/<Return>
vmap <buffer> <C-,> :s/^\(\s*\)#/\1/<Return>

" Open files with Ctrl + ]
map <buffer> <C-]> :tabfind <cfile><CR>

function! ShIgnoreFunction(buffer) abort
endfunction

let b:Ignore = function('ShIgnoreFunction')

if expand('%:r') is# '.env'
    let b:ale_linters = []
endif

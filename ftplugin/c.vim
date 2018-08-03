setlocal colorcolumn=80

if has('gui_running')
    setlocal spell
endif

let b:ale_echo_msg_format = '[%linter%] %code: %%s'
let b:ale_linters = {'c': ['clang', 'clangd']}
let b:ale_linters_ignore = {'c': ['clangd']}

if expand('%:p') =~# 'xmms2-mpris/'
    let g:ale_c_clang_options = '-std=c11 -Wall -Wno-visibility'
endif

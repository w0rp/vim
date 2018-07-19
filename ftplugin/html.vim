source ~/.vim/ftplugin/xml_plugin.vim

setlocal expandtab
" Use more space for HTML.
setlocal colorcolumn=132

" Use 2 space tabs for HTML
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

if index(split(&filetype, '\.'), 'pug') < 0
    let b:ale_linters = []
endif

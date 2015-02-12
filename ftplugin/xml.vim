source ~/.vim/ftplugin/xml_plugin.vim

let w:trim_insert_newline=0

if expand("%:e") == 'xml'
    noremap <buffer> <C-]> :tabfind <cword>.xml<CR>
endif

setlocal noexpandtab
" Use more space for XML.
setlocal cc=132

if has('gui_running')
    setlocal spell
endif


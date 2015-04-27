source ~/.vim/ftplugin/xml_plugin.vim

if expand("%:e") == 'xml'
    noremap <buffer> <C-]> :tabfind <cword>.xml<CR>
endif

setlocal noexpandtab
" Use more space for XML.
setlocal cc=132

if has('gui_running')
    setlocal spell
endif


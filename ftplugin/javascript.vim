setlocal expandtab
setlocal colorcolumn=80
" Use 2 space tabs for JavaScript
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

if has('gui_running')
    setlocal spell
endif

let b:syntastic_javascript_eslint_exe = 'eslint_d'

function! AutoFormatJavaScript()
    " Save the current position.
    let l:save = winsaveview()

    " Run js-beautify on every line.
    silent 0,$!js-beautify -

    " Write the buffer to a temporary file.
    silent :w %.eslintfix

    try
        " Run eslint on the file.
        silent !eslint --fix %.eslintfix
        " Replace the current buffer with the file we fixed.
        silent 0,$!cat %.eslintfix
    finally
        silent !rm -f %.eslintfix
    endtry

    " Fix }, ], and }, ] problems that jsbeautify causes.
    silent execute ':%s/\v^( +)  \}, \](,?)/\1  \},\r\1]\2/g'

    " Jump back to the line number and cursor before, which might be a
    " little off.
    call winrestview(l:save)

    echo 'Re-formatted code'
endfunction

map <buffer> <F8> :call AutoFormatJavaScript()<Return>

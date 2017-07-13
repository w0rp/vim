function! RunVader() abort
    try
        Vader
    finally
        cclose
    endtry
endfunction

" Map F9 to running Vader tests.
noremap <buffer> <F9> :call RunVader()<Return>

setlocal formatoptions=croql
" Continue \ lines after one is found.
setlocal comments=sO:\"\ -,mO:\"\ \ ,eO:\"\",b:\\

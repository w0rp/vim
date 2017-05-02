function! RunVader() abort
    Vader
    cclose
endfunction

" Map F9 to running Vader tests.
noremap <buffer> <F9> :call RunVader()<Return>

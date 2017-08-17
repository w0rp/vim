
" Navigate quickly in help files with space and backspace.
noremap <buffer> <space> <C-]>
noremap <buffer> <BS> <C-O>

function! CloseHelpFilesWithQ() abort
    if !&modifiable
        :q!
    else
        call feedkeys('q', 'n')
    endif
endfunction

" Quit help windows by just pressing q
nnoremap <buffer> <silent> q :call CloseHelpFilesWithQ()<CR>

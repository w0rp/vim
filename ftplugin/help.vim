" Spell check help files
setlocal spell

" Navigate quickly in help files with space and backspace.
noremap <buffer> <BS> <C-O>

function! OpenHelpTag() abort
    if !startup#keybinds#TryToOpenLink()
        call feedkeys("\<C-]>", 'n')
    endif
endfunction

" Open help tags or links with Space.
nnoremap <buffer> <silent> <space> :call OpenHelpTag()<CR>

function! CloseHelpFilesWithQ() abort
    if !&modifiable
        :q!
    else
        call feedkeys('q', 'n')
    endif
endfunction

" Quit help windows by just pressing q
nnoremap <buffer> <silent> q :call CloseHelpFilesWithQ()<CR>

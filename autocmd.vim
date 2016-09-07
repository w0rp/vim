augroup RestoreCursorPositionGroup
    autocmd!
    " Restore cursor positions for edited files.
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

augroup FiletypeGroup
    autocmd!
    " Treat lzz files like cpp files.
    au BufNewFile,BufRead *.lzz set filetype=cpp
    " .md is a markdown file.
    au BufNewFile,BufRead *.md set filetype=markdown
augroup END

" Automatically create directories on save.
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file !~# '\v^\w+\:\/'
        let dir = fnamemodify(a:file, ':h')

        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction

augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

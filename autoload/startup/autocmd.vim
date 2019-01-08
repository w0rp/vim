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
    " .pug is a Pug file.
    au BufNewFile,BufRead *.pug set filetype=pug
    " .vader is a Vader file
    au BufNewFile,BufRead *.vader set filetype=vader
    " .ts is a Typescript file
    au BufNewFile,BufRead *.ts set filetype=typescript
    " .pyi is a Python interface file.
    au BufNewFile,BufRead *.pyi set filetype=python
    " .dart is a Dart file
    au BufNewFile,BufRead *.dart set filetype=dart
    " .sublime-files are JSON files.
    au BufRead,BufNewFile *.sublime-project set filetype=json
    au BufRead,BufNewFile *.cson set filetype=coffee
augroup END

function! startup#autocmd#StopProfiling() abort
    if v:profiling
        profile pause
    endif
endfunction

" Automatically stop profiling when Vim exits.
augroup StopProfilingGroup
    autocmd!
    autocmd VimLeavePre :call startup#autocmd#StopProfiling()
augroup END

" Do auto whitespace trimming.
function! startup#autocmd#TrimWhitespace() abort
    let l:pos = getcurpos()
    silent! execute '%s/\s*$//'
    call setpos('.', l:pos)
endfunction

augroup TrimWhiteSpaceGroup
    autocmd!
    autocmd FileWritePre * :call startup#autocmd#TrimWhitespace()
    autocmd FileAppendPre * :call startup#autocmd#TrimWhitespace()
    autocmd FilterWritePre * :call startup#autocmd#TrimWhitespace()
    autocmd BufWritePre * :call startup#autocmd#TrimWhitespace()
augroup END

function! startup#autocmd#Init() abort
endfunction

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
augroup END

function! startup#autocmd#Init() abort
endfunction

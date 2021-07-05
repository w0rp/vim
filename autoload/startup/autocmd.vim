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
    au FileType typescript JsPreTmpl
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

function! startup#autocmd#MergeCompleteText(completed_item) abort
    if !has_key(a:completed_item, 'word')
        return
    endif

    let l:pos = getpos('.')
    let l:line = l:pos[1]
    let l:col = l:pos[2] - 1

    let l:line_text = getline(l:line)

    let l:word = a:completed_item.word
    let l:word_len = len(l:word)

    for l:index in range(l:word_len)
        let l:left = l:word[l:index : ]
        let l:right = l:line_text[l:col : l:col + len(l:left) - 1]

        if l:left is# l:right
            call setline(
            \   l:line,
            \   l:line_text[: l:col - 1]
            \       . l:line_text[l:col + (l:word_len - l:index) :]
            \)

            break
        endif
    endfor
endfunction

augroup AutoMergeCompleteText
    autocmd!
    autocmd CompleteDone * call startup#autocmd#MergeCompleteText(v:completed_item)
augroup END

augroup FixAfterComplete
  autocmd!
  " Run ALEFix when completion items are added.
  autocmd User ALECompletePost ALEFix!
  " If ALE starts fixing a file, stop linters running for now.
  autocmd User ALEFixPre ALELintStop
augroup END

augroup Quickfix
    autocmd!
    " Automatically close quickfix after making a selection.
    autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
augroup END

function! startup#autocmd#Init() abort
endfunction

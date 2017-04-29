function! QuitVaderResult() abort
    let l:test_filename = matchlist(
    \   getline(search('\vStarting Vader: .*\.vader', 'nw')),
    \   '\v: (.*)$'
    \)[1]

    for l:win_info in getwininfo()
        if expand('#' . l:win_info.bufnr . ':p') ==# l:test_filename
            :q!
            execute 'normal ' . l:win_info.tabnr . 'gt'
            return
        endif
    endfor

    :q!
endfunction

noremap <buffer> <C-q> :call QuitVaderResult()<Return>

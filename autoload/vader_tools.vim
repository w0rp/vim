function! s:StrList(list) abort
    return map(copy(a:list), 'string(v:val)')
endfunction

function! s:DiffLists(expected_list, actual_list) abort
    let l:expected_file = tempname()
    call writefile(s:StrList(a:expected_list), l:expected_file)

    let l:actual_file = tempname()
    call writefile(s:StrList(a:actual_list), l:actual_file)

    try
        let l:command = printf(
        \   'diff -u %s %s | tail -n +3',
        \   shellescape(l:expected_file),
        \   shellescape(l:actual_file),
        \)
        let l:output = systemlist(l:command)
    finally
        call delete(l:expected_file)
        call delete(l:actual_file)
    endtry

    return l:output
endfunction

function! vader_tools#ReplaceListsWithDiffs() abort
    set modifiable
    let l:offset = 0
    let l:line_list = getline(1, '$')

    for l:index in range(len(l:line_list))
        let l:line = l:line_list[l:index]

        let l:match = matchlist(
        \   l:line,
        \   '\v^(.*Unequal Lists)[ \n]*(\[.+\]) should be equal to[ \n]+(\[.+\])',
        \)

        if !empty(l:match)
            let l:lines_to_add = s:DiffLists(eval(l:match[3]), eval(l:match[2]))

            call setline(l:index + 1 + l:offset, l:match[1])
            call append(l:index + 1 + l:offset, l:lines_to_add)
            let l:offset += len(l:lines_to_add)
        endif
    endfor
endfunction

function! vader_tools#TryAndMakeEverythingBetter() abort
    if &filetype isnot# 'vader-result'
        return
    endif

<<<<<<< b6be34015f4ad0b4c91094bfa098821a01572618
    " call vader_tools#ReplaceListsWithDiffs()
=======
    return

    call vader_tools#ReplaceListsWithDiffs()
>>>>>>> Disable the Vader list diffs for now
endfunction

scriptencoding utf-8
" Author: w0rp <dev@w0rp.com>
" Description: A module for providing extra JavaScript tools.

function! js_tools#GetCursorInfo() abort
    let l:info = {
    \   'describes': [],
    \   'it': '',
    \}

    let l:describe_line_number = search('^ *describe(', 'bnW')

    if l:describe_line_number
        let l:last_indent = 1000000

        " for l:line in reverse(getline(1, getpos('.')[1]))
        for l:line in []
            let l:match = matchlist(l:line, '\v^( *)describe\([''"`](.+)["''`]')

            if !empty(l:match)
                let l:indent = len(l:match[1])

                if l:last_indent > l:indent
                    call add(l:info.describes, l:match[2])

                    let l:last_indent = l:indent
                endif

                if empty(l:match[1])
                    break
                endif
            endif
        endfor

        let l:describe_line = getline(l:describe_line_number)

        let l:info.describes = [substitute(
        \   l:describe_line,
        \   '\v^ +describe\([''"`](.+)[''"`].*',
        \   '\1',
        \   ''
        \)[:20]]

        call reverse(l:info.describes)

        let l:it_line_number = search('^ \+it(', 'bnW')

        if l:it_line_number
            let l:it_line = getline(l:it_line_number)

            let l:info.it = substitute(
            \   l:it_line,
            \   '\v^ +it\([''"`](.+)[''"`].*',
            \   '\1',
            \   ''
            \)[:20]
        endif
    endif

    return l:info
endfunction

function! js_tools#GetStatus() abort
    if &filetype !=# 'typescript' && &filetype !=# 'javascript'
        return ''
    endif

    let l:info = js_tools#GetCursorInfo()

    if !empty(l:info.describes)
        let l:text = join(l:info.describes, ' › ')

        if !empty(l:info.it)
            let l:text .= ' › ' . l:info.it
        endif

        return l:text
    endif

    return ''
endfunction

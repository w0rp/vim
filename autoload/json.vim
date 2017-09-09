function! s:PrettyLinesImpl(json_object, level) abort
    let l:items = []

    if type(a:json_object) == type({})
        call add(l:items, [a:level, '{'])

        for [l:key, l:value] in items(a:json_object)
            " Add commas between items.
            if len(l:items) > 1
                let l:items[-1][1] = l:items[-1][1] . ','
            endif

            if type(l:value) == type({})
                let l:sub_items = s:PrettyLinesImpl(l:value, a:level + 1)
                call add(l:items, [a:level + 1, string(l:key) . ': {'])
                call extend(l:items, l:sub_items[1:])
            elseif type(l:value) == type([])
                let l:sub_items = s:PrettyLinesImpl(l:value, a:level + 1)
                call add(l:items, [a:level + 1, string(l:key) . ': ['])
                call extend(l:items, l:sub_items[1:])
            else
                call add(l:items, [
                \   a:level + 1,
                \   string(l:key) . ': ' . string(l:value),
                \])
            endif
        endfor

        call add(l:items, [a:level, '}'])
    elseif type(a:json_object) == type([])
        call add(l:items, [a:level, '['])

        for l:value in a:json_object
            " Add commas between items.
            if len(l:items) > 1
                let l:items[-1][1] = l:items[-1][1] . ','
            endif

            let l:sub_items = s:PrettyLinesImpl(l:value, a:level + 1)

            call extend(l:items, l:sub_items)
        endfor

        call add(l:items, [a:level, ']'])
    else
        call add(l:items, [a:level, string(a:json_object)])
    endif

    return l:items
endfunction

function! json#PrettyLines(json_object, spaces) abort
    let l:lines_with_level = s:PrettyLinesImpl(a:json_object, 0)

    return map(l:lines_with_level, 'repeat('' '', v:val[0] * a:spaces) . v:val[1]')
endfunction

function! json#MakeStringPretty(spaces) abort
    let l:line_number = getcurpos()[1]
    let l:line = getline(l:line_number)

    let l:match = matchlist(l:line, '\v^(.*)''(\{.*\})''(.*$)')

    if empty(l:match)
        return
    endif

    let l:head = l:match[1]
    let l:json_string = l:match[2]
    let l:tail = l:match[3]

    let l:json_object = json_decode(l:json_string)

    let l:json_lines = json#PrettyLines(l:json_object, a:spaces)

    let l:formatted_lines = [l:head . 'json_encode(' . l:json_lines[0]]
    call extend(l:formatted_lines, map(l:json_lines[1:-2], '''\'' . v:val[1:]'))
    call add(l:formatted_lines, '\' . l:json_lines[-1] . ')' . l:tail)

    call setline(1,
    \   getline(1, l:line_number - 1)
    \   + l:formatted_lines
    \   + getline(l:line_number + 1, '$')
    \)
endfunction

function! extra_ale_fixers#AutomaticallyFixJSONDiffOutput(buffer, lines) abort
    let l:result = []

    for l:line in a:lines
        call add(l:result, substitute(l:line, '\vE   [+ ]', '    ', ''))
    endfor

    return l:result
endfunction

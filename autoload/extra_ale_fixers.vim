function! extra_ale_fixers#AutomaticallyFixJSONDiffOutput(buffer, lines) abort
    let l:result = []

    for l:line in a:lines
        let l:line = substitute(l:line, '\vE   [+ ]', '    ', '')
        let l:line = substitute(l:line, '\v": false', '": False', 'g')
        let l:line = substitute(l:line, '\v": true', '": True', 'g')
        let l:line = substitute(l:line, '\v": null', '": None', 'g')

        call add(l:result, l:line)
    endfor

    return l:result
endfunction

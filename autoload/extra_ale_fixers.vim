function! extra_ale_fixers#AutomaticallyFixJSONDiffOutput(buffer, lines) abort
    let l:result = []

    for l:line in a:lines
        let l:line = substitute(l:line, '\v": false', '": False', 'g')
        let l:line = substitute(l:line, '\v": true', '": True', 'g')
        let l:line = substitute(l:line, '\v": null', '": None', 'g')

        call add(l:result, l:line)
    endfor

    return l:result
endfunction

function! extra_ale_fixers#FixWeirdImportCommas(buffer, lines) abort
    let l:result = []

    for l:line in a:lines
        if l:line ==# '  ,'
            let l:result[-1] .= ','
        else
            call add(l:result, l:line)
        endif
    endfor

    return l:result
endfunction

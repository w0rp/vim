function! s:ApplyToLines(line, end_line, Callback) abort
    let l:lines = getline(1, '$')

    for l:index in range(a:line - 1, a:end_line - 1)
        let l:lines[l:index] = function(a:Callback)(l:lines[l:index])
    endfor

    call setline(1, l:lines)
endfunction

function! w0rp#string#ToKebabCase(string) abort
    let l:string = a:string
    let l:string = substitute(l:string, '\C\([A-Z]\)', {m -> '-' . tolower(m[1])}, 'g')
    let l:string = substitute(l:string, '^-', '', '')

    return l:string
endfunction

command! -range ToKebabCase :call s:ApplyToLines(<line1>, <line2>, 'w0rp#string#ToKebabCase')

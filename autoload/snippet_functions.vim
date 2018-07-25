function! snippet_functions#VimFunctionPrefix() abort
    let l:col = getcurpos()[2]

    if l:col > 2
        return ''
    endif

    let l:filename = expand('%:p')
    let l:autoload_path_segment = matchstr(l:filename, 'autoload[^.]*')
    let l:prefix = join(split(l:autoload_path_segment, '/')[1:], '#')

    return !empty(l:prefix) ? l:prefix . '#' : ''
endfunction

function! snippet_functions#VimFunctionPostfix() abort
    let l:col = getcurpos()[2]

    if l:col > 2
        return 'closure abort'
    endif

    return 'abort'
endfunction

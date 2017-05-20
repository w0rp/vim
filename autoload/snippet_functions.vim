function! snippet_functions#VimFunctionPrefix() abort
    let l:filename = expand('%:p')
    let l:autoload_path_segment = matchstr(l:filename, 'autoload[^.]*')
    let l:prefix = join(split(l:autoload_path_segment, '/')[1:], '#')

    return !empty(l:prefix) ? l:prefix . '#' : ''
endfunction

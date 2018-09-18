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

function! snippet_functions#MagicTypeScriptInterfaceName() abort
    let l:line = getline(search('interface', 'bn'))

    if empty(l:line)
        return ''
    endif

    let l:match = matchlist(l:line, 'interface \([a-zA-Z0-9]\+\)')

    if empty(l:match)
        return ''
    endif

    return ' ' . l:match[1]
endfunction

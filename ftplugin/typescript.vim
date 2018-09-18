setlocal expandtab
setlocal colorcolumn=81
" Use 2 space tabs for TypeScript
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal nospell
" Include - for completion.
setlocal iskeyword+=-

map <buffer> <silent> <F9> :TestFile<CR>

let b:ale_completion_excluded_words = [
\   'it',
\   'describe',
\   'beforeEach',
\   'import',
\   'implements',
\]

let s:dir = ale#path#Dirname(ale#path#FindNearestDirectory(bufnr(''), 'node_modules'))

if !empty(s:dir)
    let g:test#javascript#jest#executable = s:dir . '/node_modules/.bin/jest'
    let g:test#project_root = s:dir
endif

function! TypeScriptBindingReplacement() abort
    let l:implements_line = getline(search('implements', 'bn'))

    if empty(l:implements_line)
        return submatch(0)
    endif

    let l:match = matchlist(l:implements_line, 'implements \([a-zA-Z]\+\)')

    if empty(l:match)
        return submatch(0)
    endif

    let l:key = submatch(1)
    let l:interface = l:match[1]

    return printf('%s!: %s[''%s'']', l:key, l:interface, l:key)
endfunction

function! FixTypeScriptBindings(line1, line2) abort
    execute printf(
    \   '%s,%ss/\([a-zA-z]\+\):.*/\=TypeScriptBindingReplacement()/',
    \   a:line1, a:line2
    \)

    if getline(a:line1 - 1) !~# '// Bindings'
        call append(a:line1 - 1, '  // Bindings')
    endif
endfunction

command! -range FixBindings :call FixTypeScriptBindings(<line1>, <line2>)

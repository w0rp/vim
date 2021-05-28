setlocal expandtab
setlocal colorcolumn=81
" Use 2 space tabs for TypeScript
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal nospell
" Include - for completion.
setlocal iskeyword+=-
setlocal comments=s1:/*,mb:*,ex:*/,://,fb:-

map <buffer> <silent> <F9> :TestFile<CR>
" Use :ALEImport to import words at the cursor.
map <buffer> <C-n> <Plug>(ale_import)

let b:ale_fixers = ['eslint', 'extra_ale_fixers#FixWeirdImportCommas']
let b:ale_fix_on_save = 1
let b:ale_completion_excluded_words = [
\   'it',
\   'describe',
\   'beforeEach',
\   'import',
\   'importScripts',
\   'implements',
\]
let b:ale_exclude_highlights = [
\   'Remember not to commit fit()',
\   'Remember not to commit fdescribe()',
\]
let b:ale_javascript_eslint_options = '--ignore-pattern ''!.eslintrc.js'''
let b:ale_javascript_eslint_project_options = 'app'

let s:dir = ale#path#Dirname(ale#path#FindNearestDirectory(bufnr(''), 'node_modules'))

if !empty(s:dir)
    let g:test#enabled_runners = ['javascript#jest']
    let g:test#javascript#jest#executable = s:dir . '/node_modules/.bin/jest'
    let g:test#javascript#jest#options = '--reporters=jest-progress-bar-reporter'
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
    let l:indicator = !empty(submatch(2)) ? submatch(2) : '!'

    return printf('%s%s: %s[''%s'']', l:key, l:indicator, l:interface, l:key)
endfunction

function! FixTypeScriptBindings(line1, line2) abort
    execute printf(
    \   '%s,%ss/\([a-zA-z]\+\)\(?\?\):.*/\=TypeScriptBindingReplacement()/',
    \   a:line1, a:line2
    \)

    if getline(a:line1 - 1) !~# '// Bindings'
        call append(a:line1 - 1, '  // Bindings')
    endif
endfunction

command! -range FixBindings :call FixTypeScriptBindings(<line1>, <line2>)

imap <buffer> <silent> <C-Tab> <Plug>(ale_complete)

setlocal expandtab
setlocal colorcolumn=81
" Use 2 space tabs for JavaScript
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal nospell
" Include - for completion.
setlocal iskeyword+=-

map <buffer> <silent> <F9> :TestFile<CR>

let b:ale_fixers = ['biome', 'eslint', 'extra_ale_fixers#FixWeirdImportCommas']
let b:ale_linters = ['biome', 'eslint', 'tsserver']
let b:ale_javascript_eslint_options = '--ignore-pattern ''!.eslintrc.js'''
let b:ale_exclude_highlights = [
\   'Remember not to commit fit()',
\   'Remember not to commit fdescribe()',
\]
setlocal completeopt=menu,menuone,preview,noselect,noinsert

let s:dir = ale#path#Dirname(ale#path#FindNearestDirectory(bufnr(''), 'node_modules'))

if !empty(s:dir)
    let g:test#javascript#jest#executable = s:dir . '/node_modules/.bin/jest'
    let g:test#project_root = s:dir
endif

if expand('%:p') =~# 'git/relviz'
    let b:ale_linters = ['eslint', 'tsserver']
    let b:ale_fixers = ['eslint']
    let b:ale_fix_on_save = 1
endif

if expand('%:p') =~# 'git/juro-nx'
    setlocal noexpandtab
    let b:ale_linters = ['eslint', 'tsserver']
    let b:javascript_eslint_executable = $HOME . '/git/juro-nx/node_modules/.bin/eslint_d'
endif

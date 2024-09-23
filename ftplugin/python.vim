setlocal expandtab
setlocal colorcolumn=80
setlocal textwidth=79
" Enable comment continuation.
setlocal formatoptions+=cro
setlocal foldmethod=indent
setlocal foldminlines=10
setlocal textwidth=0

" Multi-line commenting and uncommenting.
vmap <buffer> <C-m> :s/^\(\s*\)/\1#/<Return>
vmap <buffer> <C-,> :s/^\(\s*\)#/\1/<Return>

" Use the AutoPythonImport tool.
map <buffer> <C-i> :call AutoPythonImport(expand("<cword>"))<Return>

" Change the line length for Python files based on configuration files.
function! ChangePythonLineLength() abort
    let l:conf = ale#path#FindNearestFile(bufnr(''), 'setup.cfg')
    " Reset settings back to defaults when configuration files are not found
    let l:line_length = 79

    if !empty(l:conf)
        for l:match in ale#util#GetMatches(
        \   readfile(l:conf),
        \   '\v^ *max-line-length *\= *(\d+)',
        \)
            let l:line_length = str2nr(l:match[1])
        endfor
    endif

    let &l:colorcolumn = l:line_length + 1
endfunction

call ChangePythonLineLength()

let b:ale_linters = ['ruff', 'flake8', 'pyright']
let b:ale_linters_ignore = []
" \   'ale#fixers#generic_python#BreakUpLongLines',
let b:ale_fixers = [
\   'remove_trailing_lines',
\   'isort',
\   'extra_ale_fixers#AutomaticallyFixJSONDiffOutput',
\   'ruff',
\]
let b:ale_python_pyright_config = {
\   'python': {
\       'analysis': {
\           'logLevel': 'error',
\       },
\   },
\}
let b:ale_completion_excluded_words = [
\   'DOCUMENT_DIR',
\   'DOCUMENT_EXTENSIONS',
\   'and',
\   'do',
\   'doc',
\   'if',
\   'main',
\   'main_thread',
\   'or',
\   'super',
\]
let b:ale_python_auto_virtualenv = 1

if expand('%:e') is# 'pyi'
    let b:ale_linters = ['pyright', 'ruff', 'flake8']
endif

let s:virtualenv = ale#python#FindVirtualenv(bufnr(''))

if !empty(s:virtualenv)
    if executable(s:virtualenv . '/bin/pytest')
        let s:dir = ale#path#Dirname(s:virtualenv)
        let b:test_command = ale#command#CdString(s:dir)
        \   . ale#Escape(s:virtualenv . '/bin/python') . ' -m pytest'
        \   . ' ' . ale#Escape(substitute(expand('%:p'), '^' . s:dir . '/', '', ''))
    endif
endif

if expand('%:p') =~# 'test-pylint'
    let b:ale_linters = ['pylint']
    let b:ale_python_pylint_use_global = 1
    let b:ale_python_pylint_executable = '/home/w0rp/git/test-pylint/pylint.sh'
    let b:ale_filename_mappings = {'pylint': [['/home/w0rp/git/test-pylint', '/data']]}
endif

if expand('%:p') =~# 'django-common-migration'
    let b:ale_linters_ignore = []
endif

if expand('%:p') =~# 'migrations'
    call filter(b:ale_fixers, 'v:val isnot# ''ale#fixers#generic_python#BreakUpLongLines''')
endif

if expand('%:p') =~# 'neural'
    let b:ale_fixers = ['isort']
endif

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
map <buffer> <C-n> :call AutoPythonImport(expand("<cword>"))<Return>

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

let b:ale_linters = ['flake8', 'pyright']
let b:ale_linters_ignore = []
" \   'ale#fixers#generic_python#BreakUpLongLines',
let b:ale_fixers = [
\   'remove_trailing_lines',
\   'isort',
\   'extra_ale_fixers#AutomaticallyFixJSONDiffOutput',
\   'autopep8',
\]
let b:ale_completion_excluded_words = ['and', 'or', 'if']
let b:ale_python_pyright_config = {
\   'python': {
\       'analysis': {
\           'logLevel': 'error',
\       },
\   },
\}
let b:ale_completion_excluded_words = [
\   'do',
\   'doc',
\   'super',
\   'DOCUMENT_EXTENSIONS',
\   'DOCUMENT_DIR',
\]

if expand('%:e') is# 'pyi'
    let b:ale_linters = ['pyright']
endif

function! RunPythonTests() abort
    let l:cwd = getcwd()

    " Switch the current working directory for running Django tests.
    " This tricks vim-test into working for me.
    if g:test#python#runner is# 'djangotest'
        let l:root = ale#python#FindProjectRoot(bufnr(''))

        if !empty(l:root)
            execute 'cd ' . fnameescape(l:root)
        endif
    endif

    :TestFile

    if g:test#python#runner is# 'djangotest'
        execute 'cd ' . fnameescape(l:cwd)
    endif
endfunction

let g:test#enabled_runners = ['python#pytest']

map <buffer> <silent> <F9> :call RunPythonTests()<CR>

let s:virtualenv = ale#python#FindVirtualenv(bufnr(''))

if !empty(s:virtualenv)
    if executable(s:virtualenv . '/bin/pytest')
        let g:test#python#runner = 'pytest'
        let g:test#python#pytest#executable =
        \   ale#command#CdString(ale#path#Dirname(s:virtualenv))
        \   . ale#Escape(s:virtualenv . '/bin/pytest')
    else
        let g:test#python#runner = 'djangotest'
        let g:test#python#djangotest#executable =
        \   ale#command#CdString(ale#path#Dirname(s:virtualenv))
        \   . ale#Escape(s:virtualenv . '/bin/python')
        \   . ' ' . ale#Escape(ale#path#Dirname(s:virtualenv) . '/manage.py') . ' test'
    endif
endif

if expand('%:p') =~# 'test-pylint'
    let b:ale_linters = ['pylint']
    let b:ale_python_pylint_use_global = 1
    let b:ale_python_pylint_executable = '/home/w0rp/git/test-pylint/pylint.sh'
    let b:ale_filename_mappings = {'pylint': [['/home/w0rp/git/test-pylint', '/data']]}
endif

if expand('%:p') =~# 'configurations-and-helpers'
    let b:ale_linters_ignore = []
endif

if expand('%:p') =~# 'django-common-migration'
    let b:ale_linters_ignore = []
endif

if expand('%:p') =~# 'migrations'
    call filter(b:ale_fixers, 'v:val isnot# ''ale#fixers#generic_python#BreakUpLongLines''')
endif

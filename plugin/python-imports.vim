if exists('g:loaded_python_imports')
    finish
endif

let g:loaded_python_imports = 1

function! AutoPythonImport(word)
    " Load the file with the import paths again, so we can modify the
    " dictionary while the file is still open.
    source ~/.vim/python-import-paths.vim

    " Load custom user import paths if they are there.
    if filereadable(expand('~/.python-import-paths.vim'))
        source ~/.python-import-paths.vim
    endif

    " Add in the standard import lines.
    let l:import_dict = {}
    call extend(l:import_dict, g:python_import_dict)

    " Add in extra user mappings.
    if exists('g:user_python_import_dict')
        call extend(l:import_dict, g:user_python_import_dict)
    endif

    let l:line = get(l:import_dict, a:word, '')

    " from imports should have values like 'from some_module'
    " We will automatically add on ' import something' based on the key.
    " The imports can also be written 'from some_module import x as'
    " for aliased imports.
    if l:line =~# '^from'
        if l:line =~# 'as$'
            let l:line .= ' ' . a:word
        else
            let l:line .= ' import ' . a:word
        endif
    endif

    let l:last_import_line_number = max([1, search('^import\|^from', 'bn') - 1])

    if !empty(l:line)
        " Save the current position.
        let l:line_number = line('.')
        let l:column_number = col('.')

        " Insert the import line at the end of the file. isort will sort it
        " out.
        call append(l:last_import_line_number, l:line)
        ALEFix
        " Remove any additional newlines isort mistakenly added to the end of
        " the file.
        silent! %s#\($\n\s*\)\+\%$##
        " Jump back to the line number and cursor before, which might be a
        " little off.
        call cursor(l:line_number, l:column_number)
        echo 'Import added!'
    else
        echo 'Import not found!'
    endif
endfunction

" Add functions for quickly opening import files to edit them.
function! EditGlobalPythonImports()
    :tabnew ~/.vim/python-import-paths.vim
endfunction

function! EditLocalPythonImports()
    :tabnew ~/.python-import-paths.vim
endfunction

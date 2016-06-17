if exists("g:loaded_python_imports")
    finish
endif

let g:loaded_python_imports = 1

function AutoPythonImport()
    " Load the file with the import paths again, so we can modify the
    " dictionary while the file is still open.
    source ~/.vim/python-import-paths.vim

    " Load custom user import paths if they are there.
    if filereadable(expand("~/.python-import-paths.vim"))
        source ~/.python-import-paths.vim
    endif

    " Add in the standard import lines.
    let l:import_dict = {}
    call extend(l:import_dict, g:python_import_dict)

    " Add in extra user mappings.
    if exists("g:user_python_import_dict")
        call extend(l:import_dict, g:user_python_import_dict)
    endif

    let l:line = get(l:import_dict, expand("<cword>"), "")

    if !empty(l:line)
        " Insert the import line at the beginning of the file.
        call append(0, l:line)
        python isort_file()
        echo 'Import added!'
    else
        echo 'Import not found!'
    endif
endfunction

" Add functions for quickly opening import files to edit them.
function EditGlobalPythonImports()
    :tabnew ~/.vim/python-import-paths.vim
endfunction

function EditLocalPythonImports()
    :tabnew ~/.python-import-paths.vim
endfunction

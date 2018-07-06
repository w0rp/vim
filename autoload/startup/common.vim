function! FixNewlines() abort
    execute '%s/\r//g'
endfunction

" A function because I can never remember what to type for this.
function! UnixMode() abort
    :e ++ff=unix
endfunction

" A function for setting the execute bit for scripts.
function! NewBashScript() abort
    :0put =\"#!/usr/bin/env bash\"
    :1put =\"\"
    :2put =\"set -eu\"
    :w! %
    :silent !chmod ug+x %
    :e! %
endfunction

command! Bash call NewBashScript()

" A function for setting the execute bit for scripts.
function! NewPythonScript() abort
    :0put =\"#!/usr/bin/env python \"
    :w! %
    :silent !chmod ug+x %
    :e! %
endfunction

command! Python call NewPythonScript()

" This is created for the benefit of snippet magic.
function! WriteReload() abort
    exec 'w'
    exec 'e'

    return ''
endfunction

function! StartProfiling() abort
    profile start ~/profile.log
    profile func *
    profile file *
endfunction

command! -nargs=0 CloseTabsToTheRight :silent! .+1,$tabdo :tabc
command! -nargs=0 PrettyJSON :silent call json#MakeStringPretty(2)

function! WordDiffLines(line1, line2) abort
    unsilent echom 'Differences:' system(printf(
    \   'wdiff <(echo %s) <(echo %s)',
    \   shellescape(getline(a:line1)),
    \   shellescape(getline(a:line2)),
    \))[:-2]
endfunction

command! -range=% WordDiff :silent call WordDiffLines(<line1>, <line2>)

" A command for dumping Vim variables for debugging.
command! -nargs=+ Dump :echom <q-args> . ': ' . string(eval(<q-args>))

" Commands for quickly edting commonly edited files.
function! EditVimFile(relative_path) abort
    let l:vim_dir = expand('~/.vim/')

    execute 'tabnew ' . fnameescape(l:vim_dir . a:relative_path)
endfunction

command! EditCommon :call EditVimFile('autoload/startup/common.vim')
command! EditKeybinds :call EditVimFile('autoload/startup/keybinds.vim')
command! EditSnippets :call EditVimFile('snippets/' . &filetype . '.snippets')
command! EditSyntax :call EditVimFile('syntax/' . &filetype . '.vim')
command! EditFtPlugin :call EditVimFile('ftplugin/' . &filetype . '.vim')

function! startup#common#IgnoreError(buffer) abort
    let l:Func = getbufvar(a:buffer, 'Ignore')

    if type(l:Func) != type(function('type'))
        return
    endif

    call l:Func(a:buffer)
endfunction


command! Ignore :call startup#common#IgnoreError(bufnr(''))

function! startup#common#UpdateIndexFile() abort
    if &filetype =~# 'typescript'
        call setline(1, map(glob('*', 1, 1), {_,x -> 'export * from ''./' . substitute(x, '\v\.ts', '', '') . ''''}))
    endif
endfunction

command! UpdateIndexFile :call startup#common#UpdateIndexFile()

function! startup#common#Init() abort
endfunction

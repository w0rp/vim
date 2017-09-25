if exists('g:loaded_common_functions')
    finish
endif

let g:loaded_common_functions = 1

function! FixNewlines() abort
    %s/\r//g
endfunction

" A function because I can never remember what to type for this.
function! UnixMode() abort
    :e ++ff=unix
endfunction

" A function for setting the execute bit for scripts.
function! NewBashScript() abort
    :0put =\"#!/bin/bash -eu\"
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

" Open the snippet file associated with this type of file.
function! EditSnippet() abort
    exec 'tabnew ' expand('~/.vim/snippets/' . &filetype . '.snippets')
endfunction

function! EditSyntax() abort
    exec 'tabnew ' . $HOME . '/.vim/syntax/' . &l:filetype . '.vim'
endfunction

function! EditFtPlugin() abort
    exec 'tabnew ' . $HOME . '/.vim/ftplugin/' . &l:filetype . '.vim'
endfunction

" This is created for the benefit of snippet magic.
function! WriteReload() abort
    exec 'w'
    exec 'e'

    return ''
endfunction

function! TrimWhitespace() abort
    let l:line_no = line('.')
    let l:col_no = col('.')

    %s/\s*$//

    call cursor(l:line_no, l:col_no)
endfunction

function! StartProfiling() abort
    profile start ~/profile.log
    profile func *
    profile file *
endfunction

function! StopProfiling() abort
    if v:profiling
        profile pause
    endif
endfunction

" Do auto whitespace trimming.

augroup TrimWhiteSpaceGroup
    autocmd!
    autocmd FileWritePre * :call TrimWhitespace()
    autocmd FileAppendPre * :call TrimWhitespace()
    autocmd FilterWritePre * :call TrimWhitespace()
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

" Automatically stop profiling when Vim exits.
augroup StopProfilingGroup
    autocmd!
    autocmd VimLeavePre :call StopProfiling()
augroup END

" Left brace for snippets.
let g:left_brace = "\n{"

command -nargs=0 CloseTabsToTheRight :silent! .+1,$tabdo :tabc
command -nargs=0 PrettyJSON :silent call json#MakeStringPretty(2)

function! WordDiffLines(line1, line2) abort
    unsilent echom 'Differences:' system(printf(
    \   'wdiff <(echo %s) <(echo %s)',
    \   shellescape(getline(a:line1)),
    \   shellescape(getline(a:line2)),
    \))[:-2]
endfunction

command! -range=% WordDiff :silent call WordDiffLines(<line1>, <line2>)

if exists("g:loaded_common_functions")
  finish
endif

let g:loaded_common_functions = 1

fun! FixNewlines()
    %s/\r//g
endf

" A function because I can never remember what to type for this.
fun! UnixMode()
    :e ++ff=unix
endf

" A function for setting the execute bit for scripts.
fun! NewBashScript()
    :0put =\"#!/bin/bash -eu\"
    :w! %
    :silent !chmod ug+x %
    :e! %
endf

command! Bash call NewBashScript()

" A function for setting the execute bit for scripts.
fun! NewPythonScript()
    :0put =\"#!/usr/bin/env python \"
    :w! %
    :silent !chmod ug+x %
    :e! %
endf

command! Python call NewPythonScript()

" Open the snippet file associated with this type of file.
fun! EditSnippet()
    exec 'tabnew ' . g:snippets_dir . '/' . &l:filetype . '.snippets'
endf

fun! EditSyntax()
    exec 'tabnew ' . $HOME . '/.vim/syntax/' . &l:filetype . '.vim'
endf

fun! EditFtPlugin()
    exec 'tabnew ' . $HOME . '/.vim/ftplugin/' . &l:filetype . '.vim'
endf

" This is created for the benefit of snippet magic.
func! WriteReload()
    exec 'w'
    exec 'e'

    return ''
endf

fun! TrimWhitespace()
    let line_no = line('.')
    let col_no = col('.')

    %s/\s*$//

    call cursor(line_no, col_no)
endf

" Do auto whitespace trimming.
autocmd FileWritePre * :call TrimWhitespace()
autocmd FileAppendPre * :call TrimWhitespace()
autocmd FilterWritePre * :call TrimWhitespace()
autocmd BufWritePre * :call TrimWhitespace()

" Left brace for snippets.
let g:left_brace = "\n{"

